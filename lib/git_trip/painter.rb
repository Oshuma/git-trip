module GitTrip

  # This does the work of creating a commit specific image.
  # Takes a single 40 character +sha+ string and an (optional)
  # hash of +options+ (see DEFAULTS).
  #
  # +options+ can contain:
  # * <tt>format</tt>: Image format (ex. 'png', 'gif', etc).
  # * <tt>width</tt>: Generated image size; array containing [width, height]
  class Painter
    include Magick

    DEFAULT_WIDTH  = 50
    DEFAULT_HEIGHT = 50
    DEFAULT_OPTS = {
      :format => 'png',
      :width  => DEFAULT_WIDTH,
      :height => DEFAULT_HEIGHT
    }

    attr_reader :canvas, :colors

    def initialize(sha, options = {})
      raise Errors::RTFM unless sha.is_a?(String)
      raise Errors::InvalidSHA if invalid_sha?(sha)
      @sha     = sha
      @options = DEFAULT_OPTS.merge(options)
      @colors, @remainder = split_colors
      @canvas = nil
    end

    # Generate an Image based on <tt>@colors</tt>.
    def paint!
      @canvas = ImageList.new
      @colors.each do |color|
        @canvas.new_image(@options[:width], @options[:height]) do
          self.background_color = "\##{color}"
        end
      end
      @canvas = @canvas.append(false)
    end

    private

    # Returns true if +sha+ is invalid.
    # TODO: Probably a better way of validating a SHA.
    def invalid_sha?(sha)
      sha.size != 40
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
