$:.push File.expand_path("../lib", __FILE__)
require "active_job/interactor/version"

Gem::Specification.new do |s|
  s.name        = "activejob-interactor"
  s.version     = ActiveJob::Interactor::VERSION
  s.summary     = "Run your interactors as background jobs via active job"
  s.description = "Run your interactors as background jobs via active job"
  s.authors     = ["Mark Rebec"]
  s.email       = ["mark@markrebec.com"]
  s.homepage    = "http://github.com/markrebec/activejob-interactor"

  s.files       = Dir["lib/**/*"]
  s.test_files  = Dir["spec/**/*"]

  s.add_dependency "activejob"
  s.add_dependency "interactor"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
