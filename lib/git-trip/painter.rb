module GitTrip

  # This does the work of creating a commit specific image.
  class Painter
    DEFAULTS = {
      :format => 'png',
      :header => false,
      :label  => false,
      :mode   => nil,
      :style  => 'horizontal',
      :width  => 50,
      :height => 50
    }

    STYLES = %w{
      montage
      horizontal
      vertical
    }

    attr_reader :canvas, :colors, :name, :picture

    # Takes a single 40 character +sha+ string and an (optional)
    # hash of +options+ (see DEFAULTS).
    #
    # +options+ can contain:
    # * <tt>format</tt>: Image format; anything Magick::Image.new supports (ex. 'png', 'gif', etc).
    # * <tt>header</tt>: If true, prints a header above the image, defaults to true; see +name+.
    # * <tt>label</tt>: If true, the commit SHA will be included in the image; defaults to false.
    # * <tt>name</tt>: The text to use above the commit image; only used if +header+ is true.
    # * <tt>mode</tt>: If set, will generate a picture with the given render mode.  See PaintMode::MODES.
    # * <tt>style</tt>: Generated image style; see STYLES.
    # * <tt>width</tt>: Generated commit image width.
    # * <tt>height</tt>: Generated commit image height.
    def initialize(sha, options = {})
      @options = DEFAULTS.merge(options)
      raise Errors::RTFM unless sha.is_a?(String)
      raise Errors::InvalidFormat unless Magick.formats.include?(@options[:format].upcase)
      raise Errors::InvalidSHA if invalid_sha?(sha)
      raise Errors::InvalidStyle if invalid_style?(@options[:style])
      @sha     = sha
      @colors, @remainder = split_colors
      @name = (@options[:name] || create_name)
      @canvas  = build_canvas
      @picture = nil
    end

    # Paint a <tt>@picture</tt> based on <tt>@canvas</tt> and <tt>@options[:style]</tt>.
    # Returns true or false based on the success of assigning <tt>@picture</tt>.
    def paint!
      # Need to set these locally, since <tt>Magick::ImageList#montage</tt>
      # can't access instance variables in it's block, for some reason.
      name   = @name
      header = @options[:header]
      width  = @options[:width]
      height = @options[:height]
      size = get_dimensions

      image = @canvas.montage do
        self.geometry = Magick::Geometry.new(width, height)
        self.title = name if header
        self.tile = Magick::Geometry.new(size.first, size.last) if size
      end.flatten_images

      # Conditionally apply a PaintMode.
      if @options[:mode]
        @picture = PaintMode.new(image, @options[:mode]).picture
      else
        @picture = image
      end

      @picture.format = @options[:format]
      return (@picture ? true : false)
    end

    # Saves <tt>@picture</tt> to +location+ as '<tt>name</tt>.<tt>format</tt>'.
    # Returns the <tt>@picture</tt> or nil upon failure.
    #
    # Example:
    #   painter = GitTrip::Painter.new(commit, :format => 'png')
    #   painter.paint!
    #   painter.save('/tmp', 'my_repo')
    #
    # Which would save the image as '/tmp/my_repo.png'
    def save(location, name)
      raise Errors::NoPicture unless @picture
      full_path = File.expand_path(location)
      FileUtils.mkpath(full_path) unless File.exists?(full_path)
      @picture.write("#{location}/#{name}.#{@options[:format]}")
    end

    private

    # Applies a +text+ string to a given +image+.
    def apply_label(text, image)
      image.composite(build_label(text),
        Magick::CenterGravity,
        Magick::HardLightCompositeOp)
    end

    # Builds a Magick::ImageList canvas for the <tt>@colors</tt>.
    # This is also where the label is conditionally applied.
    def build_canvas
      canvas = Magick::ImageList.new
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
    # TODO: Allow custom font options.
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
      label = label.shade(shading, 310, 30)

      return label
    end

    # Generate a name based on the remaining 4 characters of the SHA.
    # Returns the created name.
    # Only called if <tt>@options[:name]</tt> is not given.
    def create_name
      colors = @colors
      first = colors.sort_by{rand}.first.split('')[0..2].sort_by{rand}.to_s
      last  = colors.sort_by{rand}.last.split('')[0..2].sort_by{rand}.to_s
      return "--- #{first}.#{@remainder}.#{last} ---"
    end

    # Returns an array of dimensions to be used in an ImageList#montage block.
    # (ex. [4, 3])
    def get_dimensions
      case @options[:style]
      when 'horizontal'
        [@colors.size, 1]
      when 'vertical'
        [1, @colors.size]
      end
    end

    # Returns true if +sha+ is invalid.
    # TODO: Probably a better way of validating a SHA.
    def invalid_sha?(sha)
      sha.size != 40
    end

    # Returns true if +style+ is not in STYLES.
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
