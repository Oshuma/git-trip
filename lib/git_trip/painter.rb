module GitTrip

  # This does the work of creating a commit specific image(s).
  # Takes either a single SHA string <b>OR</b> an array of commit SHAs.
  class Painter
    include Magick

    def initialize(data)
      raise Errors::RTFM unless (data.is_a?(Array) || data.is_a?(String))
      @data = validate(data)
    end

    # Returns an array of RGB color codes.
    # def colors; end

    private

    # Ensures +data+ contains either a SHA string or an array of SHAs.
    # Returns +data+ if valid.
    def validate(data)
      if data.is_a? Array
        data.each { |sha| raise Errors::InvalidSHA if invalid_sha(sha) }
      else # must be a String
        raise Errors::InvalidSHA if invalid_sha(data)
      end
      # No Errors raised, return the data.
      return data
    end

    # Returns true if +sha+ is invalid.
    def invalid_sha(sha)
      raise Errors::InvalidSHA unless sha.is_a? String
      sha.size != 40
    end
  end # of Painter

end
