# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tmj_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'tmj_ruby'
  spec.version       = TMJ::VERSION
  spec.authors       = ['frbk']
  spec.email         = ['']

  spec.summary       = 'Test Managment For JIRA API Wrapper'
  spec.description   = 'Methods to work with test managment for jira api.'
  spec.homepage      = 'https://github.com/automation-wizards/tmj_ruby'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'httparty',    '~> 0.15.3'
  spec.add_development_dependency 'bundler',     '~> 1.15'
  spec.add_development_dependency 'rake',        '~> 12.0'
  spec.add_development_dependency 'rspec',       '~> 3.0'
  spec.add_development_dependency 'coveralls',   '~> 0.8.20'
  spec.add_development_dependency 'pry',         '~> 0.10.4'
  spec.add_development_dependency 'guard-rspec', '~> 4.7', '>= 4.7.3'
  spec.add_development_dependency  'vcr',        '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency  'webmock',    '~> 3.0', '>= 3.0.1'
end
