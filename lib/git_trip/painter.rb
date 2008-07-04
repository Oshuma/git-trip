module GitTrip

  # This does the work of creating a commit specific image(s).
  # Takes either a single SHA string <b>OR</b> an array of commit SHAs.
  class Painter
    def initialize(data)
      raise Errors::RTFM unless (data.is_a?(Array) || data.is_a?(String))
      raise Errors::InvalidSHA if invalid_sha?(data)
      @data = data
    end

    private

    # Returns true if there is an invalid SHA in <tt>data</tt>.
    def invalid_sha?(data)
      if data.is_a? Array
        data.each { |sha| return validate_sha(sha) }
      else
        return validate_sha(data)
      end
    end

    # Validates a given +sha+ string.
    # TODO: Probably a more 'proper' way of validating a SHA string.
    def validate_sha(sha)
      valid_status = sha.size != 40
      return valid_status
    end
  end # of Painter

end
