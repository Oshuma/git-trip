# Comma seperated list of image formats.
FORMATS = ENV['FORMATS'] ? ENV['FORMATS'].split(',') : %w{ gif jpg png }
# Output directory.
IMG_DIR = ENV['IMG_DIR']  || File.join(APP_ROOT, 'sandbox/git-trip')
# Repository to use in image generation.
IMG_REPO = ENV['IMG_REPO'] || APP_ROOT

namespace :gittrip do
  namespace :test do
    desc 'Generate test images in sandbox/git-trip'
    task :images => 'gittrip:test:images:generate'

    namespace :images do
      task :generate do
        gen_test_images(IMG_DIR, IMG_REPO)
      end

      desc 'Remove the generated test images'
      task :clear do
        FORMATS.each do |format|
          dir = File.join(IMG_DIR, format)
          header("Removing images in #{dir}")
          sh "rm -rf #{dir}/*" if File.exists?(dir)
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
def gen_test_images(dir, repo_dir)
  repo = GitTrip::Gitter::Dir.new(repo_dir)
  FORMATS.each do |format|
    base_dir = "#{dir}/#{format}"
    FileUtils.mkpath(base_dir) unless File.exists?(base_dir)
    repo.commits.each_with_index do |commit, index|
      painter = GitTrip::Painter.new(commit)
      painter.paint!
      painter.picture.write("#{base_dir}/#{index}.#{format}")
      cool_pic = GitTrip::PaintMode.new(painter.picture, :radial).picture
      cool_pic.write("#{base_dir}/#{index}-pretty.#{format}")
    end
    header("Images written to #{base_dir}")
  end
end
