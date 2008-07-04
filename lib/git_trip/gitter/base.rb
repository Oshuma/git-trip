module GitTrip
  module Gitter

    # Provides common git functionality to it's children.
    class Base
      def commits
        @data[:commits]
      end

      # Iterator for the +commits+.
      def each_commit(&block)
        @data[:commits].each { |commit| yield commit }
      end
    end # of Base

  end
end
