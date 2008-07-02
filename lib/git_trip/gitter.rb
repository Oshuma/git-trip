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

      # required
      raise Exceptions::RTFM unless options[:dir] || options[:url]
      @dir = options[:dir] || nil
      @url = options[:url] || nil
      raise Exceptions::RTFM if @dir && @url

      # optional/defaults
      handle_dir_repo if @dir
      handle_url_repo if @url
    end

    private

    # Setup a new Gitter pointing to a directory repository.
    def handle_dir_repo
    end

    # Setup a new Gitter pointing to an URL repository.
    def handle_url_repo
      raise Exceptions::InvalidFormat unless FORMATS.include?(@options[:format])
      @format = @options[:format] || 'json'
    end
  end # of Gitter

end
