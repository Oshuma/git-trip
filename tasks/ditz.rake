# Tasks that make it easier to deal with ditz.

DOC_ROOT  = File.join(APP_ROOT, 'doc') unless defined? DOC_ROOT
ISSUE_DIR = "#{DOC_ROOT}/issues"

# 'rake issues' will just list them.
desc 'List current issues'
task :issues do
  Rake::Task['issues:list'].invoke
end

namespace :issues do
  desc 'Add an issue'
  task :add do
    sh 'ditz add'
  end

  task :list do
    # Use back-tick execution to prevent output of command being run.
    # Returns a string of the command output.
    puts `ditz todo`
  end

  # 'rake issues:report' will just generate the report.
  desc 'Generate issue report'
  task :report do
    Rake::Task['issues:report:generate'].invoke
  end

  namespace :report do
    task :generate => [ 'issues:report:clear' ] do
      header "Generating issue report in #{ISSUE_DIR}"
      sh "ditz html #{ISSUE_DIR}"
    end

    desc 'Clear the issue report'
    task :clear do
      header "Removing issue report from #{ISSUE_DIR}"
      sh "rm -rf #{ISSUE_DIR}"
    end
  end
end
