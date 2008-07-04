# Tasks to handle application docs.
DOC_TITLE = "GitTrip v#{GitTrip::VERSION} Documentation"
DOC_ROOT  = File.join(APP_ROOT, 'doc') unless defined? DOC_ROOT
API_DOCS  = File.join(DOC_ROOT, 'api')

# Remove the default Hoe documentation tasks.
remove_task 'clobber_docs'
remove_task 'docs'
remove_task 'docs/index.html'
remove_task 'publish_docs'
remove_task 'redocs'
remove_task 'ridocs'

# Override the default clobber_docs task.
task :clobber_docs do
  Rake::Task['docs:clear'].invoke
end

desc 'Generate the GitTrip API docs'
task :docs do
  Rake::Task['docs:api'].invoke
end

namespace :docs do
  task :setup_rdoc do
    @file_list = FileList[ "#{APP_ROOT}/README.txt",
                           "#{APP_ROOT}/lib/**/*.rb" ]
    # Substitute APP_ROOT with a dot.  Makes for a better index in the generated docs.
    @files = @file_list.collect  {|f| f.gsub(/#{APP_ROOT}/, '.')}
    @options = %W[
      --all
      --inline-source
      --line-numbers
      --main README
      --op #{API_DOCS}
      --title '#{DOC_TITLE}'
    ]
    # Generate a diagram, yes/no?
    @options << '-d' if RUBY_PLATFORM !~ /win32/ && `which dot` =~ /\/dot/ && !ENV['NODOT']
  end

  task :api => [ :setup_rdoc ] do
    run_rdoc(@options, @files)
  end

  desc 'Remove the GitTrip API docs'
  task :clear do
    header("Removing documentation from #{API_DOCS}")
    system("rm -rf #{API_DOCS}")
  end

  desc 'Remove and rebuild the GitTrip API docs'
  task :rebuild do
    Rake::Task['docs:clear'].invoke
    Rake::Task['docs:api'].invoke
  end
end

private

# Runs rdoc with the given +options+ and +files+.
# Both arguments should be an Array, which is joined with a space.
def run_rdoc(options, files)
  options = options.join(' ') if options.is_a? Array
  files   = files.join(' ')   if files.is_a? Array
  system("rdoc #{options} #{files}")
end
