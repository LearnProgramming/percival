require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress"]
end


task :c => :console
desc "start up a irb console"
task :console do
  system 'bundle exec pry'
end


desc "start percival, connect to all channels in the CHANNELS env var" 
task :start do
  system 'mkdir -p data/timesheets/'
  channels = ENV["CHANNELS"].split(/,\s*/)
  server = 'irc.freenode.com'

  require 'percival'

  bot = Cinch::Bot.new do
    configure do |c|
      c.server = server
      c.channels = channels
      c.nick = 'percival'
      c.plugins.plugins = [ClockPlugin, LoggerPlugin]
    end
  end

  bot.start
end
