require 'rspec/core/rake_task'

task :environment do
  # noop
end

desc 'Run the specs'
RSpec::Core::RakeTask.new do |r|
  r.verbose = false
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r activejob-interactor"
end

task :build do
  puts `gem build activejob-interactor.gemspec`
end

task :push do
  require 'active_job/interactor/version'
  puts `gem push activejob-interactor-#{ActiveJob::Interactor::VERSION}.gem`
end

task release: [:build, :push] do
  puts `rm -f activejob-interactor*.gem`
end

task :default => :spec
