module GitTrip

  # This does the work of creating a commit specific image.
  class Painter
    include Magick

    DEFAULTS = {
      :style  => 'montage',
      :width  => 50,
      :height => 50
    }

    STYLES = %w{
      montage
      horizontal
      vertical
    }

    attr_reader :canvas, :colors, :picture

    # Takes a single 40 character +sha+ string and an (optional)
    # hash of +options+ (see DEFAULTS).
    #
    # +options+ can contain:
    # * <tt>format</tt>: Image format; anything Magick::Image.new supports (ex. 'png', 'gif', etc).
    # * <tt>style</tt>: Generated image style; see STYLES.
    # * <tt>width</tt>: Generated commit image width.
    # * <tt>height</tt>: Generated commit image height.
    def initialize(sha, options = {})
      raise Errors::RTFM unless sha.is_a?(String)
      raise Errors::InvalidSHA if invalid_sha?(sha)
      @sha     = sha
      @options = DEFAULTS.merge(options)
      raise Errors::InvalidStyle if invalid_style?(@options[:style])
      @colors, @remainder = split_colors
      @canvas  = build_canvas
      @picture = nil
    end

    # Generate an image based on <tt>@canvas</tt> and <tt>@options[:style]</tt>.
    def paint!
      # Need to set these locally, since <tt>Magick::ImageList#montage</tt>
      # can't access <tt>@options</tt> in it's block, for some reason.
      width  = @options[:width]
      height = @options[:height]

      case @options[:style]
      when 'horizontal'
        @picture = @canvas.append(false)
      when 'vertical'
        @picture = @canvas.append(true)
      when 'montage'
        @picture = @canvas.montage do
          self.geometry = Magick::Geometry.new(width, height, 0, 0)
        end
      end
    end

    private

    # Builds a Magick::ImageList for the <tt>@colors</tt>.
    def build_canvas
      canvas = ImageList.new
      @colors.each do |color|
        canvas.new_image(@options[:width], @options[:height]) do
          self.background_color = "\##{color}"
        end
      end
      return canvas
    end

    # Returns true if +sha+ is invalid.
    # TODO: Probably a better way of validating a SHA.
    def invalid_sha?(sha)
      sha.size != 40
    end

    # Returns true if +options[:style]+ exists and is not in STYLES.
    def invalid_style?(style)
      return true unless STYLES.include?(style)
    end

    # Returns a 6 element array of RGB color codes, and the
    # remaining 4 characters (as a string).
    def split_colors
      array     = []
      remainder = @sha.split('') # Yes, it's not the remainder now, but it will be at the return statement.
      6.times { array << remainder.slice!(0, 6).to_s }
      return array, remainder.to_s
    end
  end # of Painter

end
