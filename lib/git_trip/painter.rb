module GitTrip

  # This does the work of creating a commit specific image.
  # Takes single 40 character SHA string.
  class Painter
    include Magick

    def initialize(sha)
      raise Errors::RTFM unless sha.is_a?(String)
      raise Errors::InvalidSHA if invalid_sha?(sha)
      @sha = sha
    end

    # Returns a 5 element array of RGB color codes.
    def colors
      array = []
      all   = @sha.split('')
      5.times { array << all.slice!(0, 8).to_s }
      return array
    end

    private

    # Returns true if +sha+ is invalid.
    def invalid_sha?(sha)
      sha.size != 40
    end
  end # of Painter

end
