# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stubber/version"

Gem::Specification.new do |s|
  s.name        = "stubber"
  s.version     = Stubber::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Scott Gonyea"]
  s.email       = ["me@sgonyea.com"]
  s.homepage    = "http://github.com/sgonyea/string_stubber"
  s.summary     = %q{Allows you to truncate Strings, while preserving whole-words.}
  s.description = %q{Stubber allows you to truncate Strings, while preserving whole-words.}

  s.add_dependency 'yard', '~>0.6'

  s.add_development_dependency 'rspec', '~>2.4'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
