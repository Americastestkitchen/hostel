# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hostel/version'

Gem::Specification.new do |spec|
  spec.name          = 'hostel'
  spec.version       = Hostel::VERSION
  spec.authors       = ['Chris Candelora', 'Patrick Hereford', 'Jonathan Lukens']
  spec.email         = ['chris.candelora@americastestkitchen.com', 'patrick.hereford@americastestkitchen.com', 'jonathan.lukens@americastestkitchen.com']
  spec.summary       = %q{Quick and dirty multitenancy for Rails applications.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rspec', '~> 2.6'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rake'
end
