# -*- encoding: utf-8 -*-
require File.expand_path('../lib/percival/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Fredette"]
  gem.email         = ["jfredett@gmail.com"]
  gem.description   = %q{A IRC bot for the vermonster team.}
  gem.summary       = %q{A IRC bot for the vermonster team.}
  gem.homepage      = ""

  gem.add_dependency "cinch"
  gem.add_dependency "rake"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "percival"
  gem.require_paths = ["lib"]
  gem.version       = Percival::VERSION
end
