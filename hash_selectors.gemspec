require "rake"

spec = Gem::Specification.new do |s|
  s.name        = "hash_selectors"
  s.version     = "0.0.2"
  s.summary     = "Some select methods for Ruby Hashes"
  s.description = "Provides additional select-type methods for Ruby Hashes"
  s.authors     = ["Kevin C. Baird"]
  s.email       = "kcbaird@world.oberlin.edu"
  s.files       = FileList["lib/hash_selectors.rb", "lib/hash_selectors/*.rb", "spec/**.rb", "LICENSE", "README.md"]
  s.has_rdoc    = 'yard'
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.homepage    = 'https://github.com/kbaird/hash-selectors'
  s.add_dependency "rspec",     "~> 3.0"
  s.add_dependency "simplecov", "~> 0.8"
end

