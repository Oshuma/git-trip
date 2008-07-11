# Saves me some typing...
BRANCH = ENV['BRANCH'] || 'master'
REPOS  = ENV['REPOS']  || 'github,gitorious,rubyforge'

namespace :gittrip do
  desc 'Push BRANCH to REPOS'
  task :push do
    repos.each do |repo|
      sh "git push #{repo} #{BRANCH}"
    end
  end
end

private

def repos
  REPOS.split(',')
end
