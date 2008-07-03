module GitTrip

  module Gitter
    # Handles fetching git repository information from a remote URI.
    # <b>Required:</b>
    # * <tt>dir</tt>: Directory path to a git repository (containing a .git/ subdirectory).
    class Dir
      def initialize(dir, options = {})
        raise Errors::DirNotFound unless File.exists?(dir)
        raise Errors::InvalidGitRepo unless File.exists?("#{dir}/.git/")
        @dir = dir
      end
    end # of Dir
  end # of Gitter

end
