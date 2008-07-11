module GitTrip

  class PaintMode
    MODES = [
      :blend,
      :pixel,
      :radial
    ]

    attr_reader :picture

    # This class takes an +image+ generated from GitTrip::Painter and does
    # something pretty with it.  +mode+ can be anything listed in MODES, as
    # a string or symbol.  There's a 'picture' reader that returns the
    # generated Magick::Image.
    #
    # Example:
    #   painter = GitTrip::Painter.new(commit_sha)
    #   painter.paint!  # Create the commit specific image.
    #   pretty = GitTrip::PaintMode.new(painter.picture, :pixel)
    #   # pretty now holds a Magick::Image.
    #   pretty.display
    def initialize(image, mode)
      raise Errors::InvalidPicture unless image.is_a?(Magick::Image)
      raise Errors::InvalidMode unless MODES.include?(mode.to_sym)
      @mode = mode.to_sym
      @image = image

      @picture = case @mode
      when :blend:  blend_mode
      when :pixel:  pixel_mode
      when :radial: radial_mode
      end
    end

    # Blend <tt>@image</tt>.
    def blend_mode(distance = 35)
      @image.motion_blur(0, distance, 180)
    end

    # Pixelize <tt>@image</tt>.
    def pixel_mode
      @image.ordered_dither
    end

    # Radialize <tt>@image</tt>
    def radial_mode
      @image.radial_blur(90)
    end
  end # of PaintMode

end
