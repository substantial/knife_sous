# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.authors     = "Shaun Dern"
  s.email       = "shaun@substantail.com"

  s.name        = 'knife_sous'
  s.version     = "0.1.0pre"
  s.description = %q{Knife plugin for managing knife-solo nodes}
  s.summary     = %q{A Chef Knife plugin which uses a DSL to configure and
manage knife solo nodes. Run knife solo commands on one or multiple nodes.}
  s.homepage    = %q{http://github.com/substantial/knife_sous}
  s.license     = "MIT"

  s.rubyforge_project = "knife_sous"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.14.1"
  s.add_development_dependency "rake", "~> 10.1.0"
  s.add_development_dependency "bundler", "~> 1.3.5"
  s.add_dependency "knife-solo", "~> 0.3.0"
end

