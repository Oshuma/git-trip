# OverrideRakeTask - http://tools.assembla.com/svn/rails_plugins/override_rake_task/
Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

def remove_task(task_name)
  Rake.application.remove_task(task_name)
end

def override_task(args, &block)
  name, deps = Rake.application.resolve_args(args)
  remove_task Rake.application[name].name
  task(args, &block)
end


#
# Utility methods.
#
# Ask for confirmation.  Returns true/false
def confirm(message, options = {})
  confirm_message = options[:confirm_message] || 'Are you sure?'
  banner = options[:banner] || false
  banner ? header(message) : puts("\n#{message}")
  print "#{confirm_message} (yes/no) "
  choice = STDIN.gets.chomp

  case choice
  when 'yes'
    return true
  else
    puts 'Aborted'
  end
end

# Displays +message+ inside a formatted header.
def header(message)
  puts "\n"
  puts '+---'
  puts "| #{message}"
  puts '+---'
end
