module GitTrip
  module Gitter

    # Handles fetching git repository information from a directory.
    class Dir < Gitter::Base
      # <tt>dir</tt> should be a path to a git repository (containing a .git/ subdirectory).
      def initialize(dir, options = {})
        raise Errors::DirNotFound unless File.exists?(dir)
        @repo = Grit::Repo.new(dir)
        @data = {}
        setup_data_hash
      end

      private

      # Loads the <tt>@data</tt> hash with repository information.
      def setup_data_hash
        load_repo_commits
      end

      # Loads a hash of commits into <tt>@data[:commits]</tt>.
      def load_repo_commits
        commits = []
        @repo.commits(@repo.head.name, @repo.commit_count).map do |c|
          commits << c.to_s
        end
        @data[:commits] = commits
      end
    end # of Dir

  end # of Gitter
end
