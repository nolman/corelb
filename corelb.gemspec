# -*- encoding: utf-8 -*-

require File.expand_path('../lib/corelb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'corelb'
  gem.version       = Corelb::VERSION
  gem.summary       = %q{TODO: Summary}
  gem.description   = %q{TODO: Description}
  gem.license       = 'MIT'
  gem.authors       = ['Nolan Evans']
  gem.email         = 'nolane@gmail.com'
  gem.homepage      = 'https://rubygems.org/gems/corelb'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
