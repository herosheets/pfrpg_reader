$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pfrpg_readers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pfrpg_readers"
  s.version     = PfrpgReaders::VERSION
  s.authors     = ["Jordan OMara"]
  s.email       = ["jordan@herosheets.com"]
  s.homepage    = "http://herosheets.com"
  s.summary     = "PFRPG readers"
  s.description = "readers"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end
