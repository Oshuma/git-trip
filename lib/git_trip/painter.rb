module GitTrip

  # This does the work of creating a commit specific image.
  # <tt>commits</tt>: An array of SHAs.
  # <tt>size</tt>: Canvas size; eg. number of generated images; defaults to 5
  class Painter
    attr_reader :size

    def initialize(commits, size = 5)
      raise Errors::NoCommits unless commits.is_a? Array
      raise Errors::CanvasTooSmall if commits.size < size
      @commits, @size = commits, size
    end
  end # of Painter

end
