# encoding: UTF-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elo/version'

Gem::Specification.new do |s|
  s.name = 'elo2'
  s.version = Elo::VERSION

  s.authors = ['John Hawthorn']
  s.email = ['john.hawthorn@gmail.com']

  s.description = 'The Elo rating system is a method for calculating the relative skill levels of players in two-player games such as cess and Go.'
  s.summary = 'The Elo rating system is a method for calculating the relative skill levels of players in two-player games such as cess and Go.'

  s.files = Dir['README.md', 'lib/**/*']
  s.homepage = 'http://github.com/iain/elo'
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'bundler', '~> 1.9'
  s.add_development_dependency 'rake', '~> 10.0'
end
