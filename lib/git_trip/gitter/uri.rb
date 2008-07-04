module GitTrip
  module Gitter

    # Handles fetching git repository information from a remote URI.
    # <b>Required:</b>
    # * <tt>uri</tt>: URI which returns information about a git repository (see +format+).
    #
    # <tt>options</tt> can be a hash containing:
    # <b>Optional:</b>
    # * <tt>format</tt>: Defaults to 'json'; see FORMATS.
    class URI < Gitter::Base
      FORMATS   = %w{ json xml yaml }
      PROTOCOLS = %w{ http https }

      DEFAULTS = {
        :format => 'json'
      }

      def initialize(uri, options = {})
        raise Errors::InvalidURI if invalid_uri?(uri)
        @uri = uri
        @options = DEFAULTS.merge(options)
        raise Errors::InvalidFormat if invalid_format?(@options[:format])
      end

      private

      # Returns true if the given +format+ is invalid.
      def invalid_format?(format)
        return true unless FORMATS.include?(format)
      end

      # Returns true if the given +uri+ is invalid.
      def invalid_uri?(uri)
        uri.grep(/^(#{PROTOCOLS.join('|')}):\/\/\w/).empty?
      end
    end # of URI

  end # of Gitter
end
