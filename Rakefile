require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new


task :c => :console
desc "start up a irb console"
task :console do
  system 'bundle exec irb'
end
