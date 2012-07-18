$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "db_debug/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "db_debug"
  s.version     = DbDebug::VERSION
  s.authors     = ["Phil Monroe", "Identified"]
  s.email       = ["phil@identified.com"]
  s.homepage    = "https://github.com/Identified/db_debug"
  s.summary     = "Summary of DbDebug."
  s.description = "Description of DbDebug."

  s.files = Dir["{config,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.0"
end
