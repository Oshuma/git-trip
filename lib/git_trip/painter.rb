module GitTrip

  # This does the work of creating a commit specific image.
  class Painter
    include Magick

    DEFAULTS = {
      :label  => false,
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
    # TODO: Implement @options[:format]
    #
    # +options+ can contain:
    # * <tt>format</tt>: Image format; anything Magick::Image.new supports (ex. 'png', 'gif', etc).
    # * <tt>label</tt>: If true, the commit SHA will be included in the image; defaults to false.
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

    # Paint a <tt>@picture</tt> based on <tt>@canvas</tt> and <tt>@options[:style]</tt>.
    def paint!
      case @options[:style]
      when 'horizontal': paint_horizontal
      when 'vertical':   paint_vertical
      when 'montage':    paint_montage
      else
        raise Errors::InvalidStyle
      end
    end

    # Builds the <tt>@picture</tt>.
    # Called if <tt>@options[:style] == 'montage'</tt>.
    def paint_montage
      raise Errors::RTFM unless @options[:style] == 'montage'

      # Need to set these locally, since <tt>Magick::ImageList#montage</tt>
      # can't access <tt>@options</tt> in it's block, for some reason.
      width  = @options[:width]
      height = @options[:height]

      @picture = @canvas.montage do
        self.geometry = Magick::Geometry.new(width, height, 0, 0)
      end.flatten_images
    end

    # Builds the <tt>@picture</tt>.
    # Called if <tt>@options[:style] == 'horizontal'</tt>.
    def paint_horizontal
      raise Errors::RTFM unless @options[:style] == 'horizontal'
      @picture = @canvas.append(false)
    end

    # Builds the <tt>@picture</tt>.
    # Called if <tt>@options[:style] == 'vertical'</tt>.
    def paint_vertical
      raise Errors::RTFM unless @options[:style] == 'vertical'
      @picture = @canvas.append(true)
    end

    private

    # Applies a +text+ string to a given +image+.
    def apply_label(text, image)
      image.composite(build_label(text),
        Magick::CenterGravity,
        Magick::HardLightCompositeOp)
    end

    # Builds a Magick::ImageList canvas for the <tt>@colors</tt>.
    def build_canvas
      canvas = ImageList.new
      @colors.each do |color|
        image = Magick::Image.new(@options[:width], @options[:height]) do
          self.background_color = "\##{color}"
        end
        canvas << (@options[:label] ? apply_label(color, image) : image)
      end
      return canvas
    end # of build_canvas

    # Builds an image with the given +text+.
    # TODO: Find a sane way of setting the pointsize.
    # TODO: Allow a custom font options.
      def build_label(text)
        shading = false

        label = Magick::Image.new(@options[:width], @options[:height])
        image = Magick::Draw.new
        image.gravity = Magick::CenterGravity
        image.pointsize = @options[:width] / 4
        image.font = 'Helvetica'
        image.font_weight = Magick::NormalWeight
        image.stroke = 'none'
        image.annotate(label, 0, 0, 0, 0, text)
        return label.shade(shading, 310, 30)
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
