module GitTrip

  # This does the work of creating a commit specific image.
  # <tt>commits</tt>: An array of SHAs.
  # <tt>size</tt>: Canvas size; eg. number of generated images; defaults to +commits.size+.
  class Painter
    attr_reader :size

    def initialize(commits)
      raise Errors::NoCommits unless commits.is_a? Array
      @commits, @size = commits, commits.size
    end

    # Iterator for the +commits+.
    def each_commit(&block)
      @commits.each { |commit| yield commit }
    end
  end # of Painter

end
