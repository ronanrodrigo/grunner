class RunnerGenerator < Rails::Generators::NamedBase
  def create_runner_file
    git_user_name = `git config user.name`.chomp
    git_user_email = `git config user.email`.chomp
    today = I18n.l(Date.today, format: :long)
    last_file_number = 0
    if Dir.glob("./lib/runners/*[0-9]_*.rb").last
      last_file_number = Dir.glob("./lib/runners/*[0-9]_*.rb").last[/\d+(?:\.\d+)?/].to_i || 0
    end
    create_file "lib/runners/#{last_file_number+1}_#{file_name}.rb", %Q{# #{today}
# #{git_user_name} / #{git_user_email}
# Describe your file here!

class #{file_name.camelize}
  def self.setup
    time = Benchmark.realtime do
      puts("Start! #{file_name.camelize}")
      # [E.T. and Elliot embrace each other, then E.T. puts his glowing finger to Elliot's forehead] I'll... be... right... here.
    end
    puts "End! UserToken. Time elapsed \#{time.seconds}\ seconds"
  end
end
#{file_name.camelize}.setup}
  end
end
