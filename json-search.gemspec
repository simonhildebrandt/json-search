Gem::Specification.new do |s|
  s.name        = "json-search"
  s.version     = "0.0.1"
  s.summary     = "Efficiently search a JSON document"
  s.description = "Efficiently search a JSON document"
  s.authors     = ["Simon Hildebrandt"]
  s.email       = "simonhildebrandt@gmail.com"
  s.files       = [
    "lib/json-search.rb",
    "lib/json-client-db.rb",
    "lib/json-search-cli.rb"
  ]
  s.homepage    = "https://github.com/simonhildebrandt/json-search"
  s.license     = "MIT"
  s.add_dependency 'sqlite3', '~> 2.0.2'
  s.add_development_dependency 'rspec'
  s.executables << 'json-search'
end
