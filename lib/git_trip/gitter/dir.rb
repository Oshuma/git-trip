module GitTrip
  module Gitter

    # Handles fetching git repository information from a directory.
    # <b>Required:</b>
    # * <tt>dir</tt>: Directory path to a git repository (containing a .git/ subdirectory).
    class Dir < Gitter::Base
      def initialize(dir, options = {})
        raise Errors::DirNotFound unless File.exists?(dir)
        @repo = Grit::Repo.new(dir)
        @data = {}
        load_repo_data
      end

      private

      # Returns a hash of repository information.
      def load_repo_data
        @data[:commits] = @repo.commits.map { |c| c.to_s  }
      end
    end # of Dir

  end # of Gitter
end
