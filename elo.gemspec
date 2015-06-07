# encoding: UTF-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elo/version'

Gem::Specification.new do |s|
  s.name = "elo"
  s.version = Elo::VERSION

  s.authors = ["Iain Hecker"]
  s.email = ["iain@iain.nl"]

  s.description = %q{The Elo rating system is a method for calculating the relative skill levels of players in two-player games such as cess and Go.}
  s.summary = %q{The Elo rating system is a method for calculating the relative skill levels of players in two-player games such as cess and Go.}

  s.files = Dir['README.md', 'lib/**/*']
  s.homepage = %q{http://github.com/iain/elo}
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 3.0"
end

