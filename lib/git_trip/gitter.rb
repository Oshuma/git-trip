module GitTrip

  # Gitter handles the interaction between GitTrip and git.
  # (Note: It has nothing to do with twitter, despite the name.)
  # <tt>options</tt> can be a hash containing:
  # <b>Required:</b>
  # * <tt>dir</tt>: Directory path to a git repository (containing a .git/ directory).
  # * <tt>url</tt>: URL which returns information about a git repository (see +format+).
  #
  # <b>Optional:</b>
  # * <tt>format</tt>: Only used when +url+ is specified; defaults to 'json'; see FORMATS.
  class Gitter
    FORMATS = %w{ json xml yaml }

    def initialize(options = {})
      @options = options # store a copy of the passed options

      # dir OR url, NOT both
      raise Errors::RTFM unless options[:dir] || options[:url]
      @dir = options[:dir] || nil
      @url = options[:url] || nil
      raise Errors::RTFM if @dir && @url

      # optional/defaults
      setup_dir_repo if @dir
      setup_url_repo if @url
    end

    private

    # Setup a new Gitter pointing to a directory repository.
    def setup_dir_repo
      raise Errors::DirNotFound unless File.exists?(@dir)
      raise Errors::InvalidGitRepo unless File.exists?("#{@dir}/.git")
    end

    # Setup a new Gitter pointing to an URL repository.
    def setup_url_repo
      @format = @options[:format] || 'json'
      raise Errors::InvalidFormat unless FORMATS.include?(@format)
    end
  end # of Gitter

end
