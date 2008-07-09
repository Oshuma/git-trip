module GitTrip
  module Gitter

    # Handles fetching git repository information Github.
    class GitHub < Gitter::Base
      FORMATS = %w{ json xml }
      DEFAULTS = {
        :format => 'json'
      }

      # Takes a GitHub +tag+ in the form of 'Username/repository'.
      # ex. 'Oshuma/git-trip'.
      #
      # +options+ can be a hash containing:
      # * <tt>format</tt>: See FORMATS; defaults to 'json'.
      #
      # TODO: Add 'branch' option; default to master.
      def initialize(tag, options = {})
        raise Errors::InvalidGitHubTag if invalid_tag?(tag)
        @options = DEFAULTS.merge(options)
        raise Errors::InvalidFormat if invalid_format?(@options[:format])
        @tag  = tag
        @uri  = "http://github.com/api/v1/#{@options[:format]}/#{@tag}/commits/master"
        @data = {}
        @repo = nil
        fetch_repo
        setup_data_hash
      end

      private

      # Fetches repository information from the <tt>@uri</tt>.
      def fetch_repo
        @repo = case @options[:format]
        when 'json'
          JSON.parse(open(@uri).read).symbolize_keys
        end
        @repo[:commits].each { |h| h.symbolize_keys! if h.is_a? Hash }
      end

      # Returns true if the given +format+ is invalid.
      def invalid_format?(format)
        return true unless FORMATS.include?(format)
      end

      # Returns true if the given +tag+ is not formatted as such:
      # 'Username/repo_name'
      def invalid_tag?(tag)
        tag.grep(/\w*\/\w*/).empty?
      end

      # Loads the <tt>@data</tt> hash with repository information.
      def setup_data_hash
        load_repo_commits
      end

      # Loads a hash of commits into <tt>@data[:commits]</tt>.
      def load_repo_commits
        commits = []
        @repo[:commits].each do |commit|
          commits << commit[:id]
        end
        @data[:commits] = commits
      end
    end # of GitHub

  end # of Gitter
end
