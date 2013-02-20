# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ropl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["CLR"]
  gem.email         = ["clr@port49.com"]
  gem.description   = %q{Riak Object Persistence Layer}
  gem.summary       = %q{Why bother with an ORM? Just store the object. This is OOP, after all.}
  gem.homepage      = ""

  gem.add_dependency "riak-client", "~> 1.0.0"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ropl"
  gem.require_paths = ["lib"]
  gem.version       = Ropl::VERSION
end
