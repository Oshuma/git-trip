module GitTrip

  module Gitter
    # Handles fetching git repository information from a remote URI.
    # <b>Required:</b>
    # * <tt>uri</tt>: URI which returns information about a git repository (see +format+).
    #
    # <tt>options</tt> can be a hash containing:
    # <b>Optional:</b>
    # * <tt>format</tt>: Defaults to 'json'; see FORMATS.
    class URI
      FORMATS   = %w{ json xml yaml }
      PROTOCOLS = %w{ http https }

      def initialize(uri, options = {})
        @uri      = validate_uri(uri)
        @format   = validate_format(options[:format])
      end

      # Returns an array of commits
      def commits
        @data[:commits]
      end

      # Fetches the repository information from +uri+ in the given +format+.
      def load_data!
        stream = open(@uri)
        case @format
        when 'json':
          @data = JSON.parse(open(@uri).read)
        end
      end

      private

      # Ensures a proper +format+ is given.
      def validate_format(format)
        case format
        when nil:
          return 'json'
        when FORMATS.include?(format):
          return format
        end
      end

      # Ensures a proper +uri+ is given.
      def validate_uri(uri)
        raise Errors::InvalidURI unless uri
        raise Errors::InvalidURI if uri.grep(/^(#{PROTOCOLS.join('|')}):\/\/\w/).empty?
        return uri
      end
    end # of URI
  end # of Gitter

end
