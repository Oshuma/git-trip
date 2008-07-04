module GitTrip

  # This does the work of creating a commit specific image.
  # Takes a single 40 character +sha+ string and an (optional)
  # hash of +options+ (see DEFAULTS).
  #
  # +options+ can contain:
  # * <tt>format</tt>: Image format (ex. 'png', 'gif', etc).
  # * <tt>style</tt>: See STYLES.
  # * <tt>width</tt>: Generated image width.
  # * <tt>height</tt>: Generated image height.
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

    # Generate an Image based on <tt>@canvas</tt>.
    def paint!
      case @options[:style]
      when 'horizontal'
        @picture = @canvas.append(false)
      when 'vertical'
        @picture = @canvas.append(true)
      when 'montage'
        @picture = @canvas.montage do
          self.geometry = Magick::Geometry.new(50, 50, 0, 0)
          # self.geometry = Magick::Geometry.new(@options[:width], @options[:height], 0, 0)
          # self.geometry = Magick::Geometry.new("#{@options[:width]}x#{@options[:height]}+0+0")
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

    # Returns a 5 element array of RGB color codes, and the
    # remaining 4 characters (as a string).
    def split_colors
      array = []
      all   = @sha.split('')
      6.times { array << all.slice!(0, 6).to_s }
      return array, all.to_s
    end
  end # of Painter

end
