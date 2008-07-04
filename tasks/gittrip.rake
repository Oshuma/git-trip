FORMATS = %w{ gif jpg png }
IMG_DIR = ENV['IMG_DIR'] || File.join(APP_ROOT, 'sandbox/git-trip')

namespace :gittrip do
  namespace :test do
    desc 'Generate test images in sandbox/git-trip'
    task :images => 'gittrip:test:images:generate'

    namespace :images do
      task :generate do
        gen_test_images(IMG_DIR)
      end

      desc 'Remove the generated test images'
      task :clear do
        FORMATS.each do |format|
          dir = File.join(IMG_DIR, format)
          header("Removing images in #{dir}")
          sh "rm -rf #{dir}/*"
        end
      end

      desc 'Regenerate the test images'
      task :rebuild do
        Rake::Task['gittrip:test:images:clear'].invoke
        Rake::Task['gittrip:test:images:generate'].invoke
      end
    end
  end
end

# Generate test images in the given directory.
# Uses APP_ROOT as the git repository.
def gen_test_images(dir)
  repo = GitTrip::Gitter::Dir.new(APP_ROOT)
  FORMATS.each do |format|
    repo.commits.each_with_index do |commit, index|
      painter = GitTrip::Painter.new(commit)
      painter.paint!
      painter.picture.write("#{dir}/#{format}/#{index}.#{format}")
    end
  end
end
