Gem::Specification.new do |spec|
  spec.name          = "embulk-output-sqlite3"
  spec.version       = "0.0.1"
  spec.authors       = ["Yuichi Takada"]
  spec.email         = ["takadyuichi@gmail.com"]
  spec.summary       = "SQLite3 output plugin for Embulk"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/takady/embulk-output-sqlite3"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "jdbc-sqlite3"
end
