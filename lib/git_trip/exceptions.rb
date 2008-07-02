module GitTrip

  # Holds Exceptions specific to GitTrip.
  module Exceptions
    class Exception
      # Prints a helpful +message+ when raised.
      # +output+ can be anything that supports +puts+; defaults to <tt>$stderr</tt>.
      def self.helpful(message, output = $stderr)
        $stderr.puts "#{name} - #{message}"
      end
    end

    class InvalidFormat < Exception
    rescue
      helpful('See the API docs for GitTrip::Gitter.')
    end

    class RTFM < Exception
    rescue
      helpful('Read the GitTrip API!')
    end
  end

end
