# Tasks for dealing with the RubyForge site.

# The local directories to store the website files.
DOC_ROOT      = File.join(APP_ROOT, 'doc') unless defined? DOC_ROOT
LOCAL_SITE    = File.join(DOC_ROOT, 'rubyforge.site')
SITE_API      = File.join(LOCAL_SITE, 'api')
SITE_ISSUES   = File.join(LOCAL_SITE, 'issues')

# The remote directory the files will be scp'ed to.
REMOTE_SITE = 'git-trip.rubyforge.org:/var/www/gforge-projects/git-trip'

# A list of static pages to upload.
PAGES = %w{
  index.html
  robots.txt
}

namespace :gittrip do
  namespace :site do
    desc 'Clear the local site directory of dynamic files'
    task :clear_local do
      header("Clearing local site directory: #{LOCAL_SITE}")
      sh "rm -rf #{SITE_API}"      if File.exists? SITE_API
      sh "rm -rf #{SITE_ISSUES}"   if File.exists? SITE_ISSUES
    end

    # Copies the issue and docs to the site directory.
    task :setup_dir => [ :clear_local, :run_external_tasks ] do
      header('Copying issues and API docs to the site directory.')
      FileUtils.cp_r(API_DOCS, LOCAL_SITE)
      FileUtils.cp_r(ISSUE_DIR, LOCAL_SITE)
    end

    desc 'Upload the issues and docs to the website'
    task :upload => :setup_dir do
      header('Uploading local site to remote site.')
      sh "cd #{LOCAL_SITE} && scp -r ./* #{REMOTE_SITE}"
    end

    private

    # Used to shorten the setup_site_dir task definition.
    task :run_external_tasks do
      Rake::Task['docs:rebuild'].invoke
      Rake::Task['issues:report'].invoke
    end
  end
end