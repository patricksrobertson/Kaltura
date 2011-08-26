# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kaltura/version"

Gem::Specification.new do |s|
  s.name        = "kaltura"
  s.version     = Kaltura::VERSION
  s.authors     = ["Patrick Robertson"]
  s.email       = ["patricksrobertson@gmail.com"]
  s.homepage    = "https://github.com/patricksrobertson/kaltura"
  s.summary     = %q{A ruby client for the Kaltura API.}
  s.description = %q{A ruby client for the Kaltura API.}

  s.rubyforge_project = "kaltura"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("httparty", ">= 0.7.8")
  s.add_dependency("hashie", ">= 1.0.0")  
  s.add_development_dependency("rspec", "~> 2.6.0")
  s.add_development_dependency("vcr", "~> 1.11.1")
  s.add_development_dependency("webmock", "~> 1.7")
end
