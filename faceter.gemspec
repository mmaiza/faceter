$:.push File.expand_path("../lib", __FILE__)
require "faceter/version"

Gem::Specification.new do |gem|

  gem.name        = "faceter"
  gem.version     = Faceter::VERSION.dup
  gem.author      = "Andrew Kozin"
  gem.email       = "andrew.kozin@gmail.com"
  gem.homepage    = "https://github.com/nepalez/faceter"
  gem.summary     = "ROM-compatible data mapper"
  gem.license     = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files       = Dir["spec/**/*.rb"]
  gem.extra_rdoc_files = Dir["README.md", "LICENSE"]
  gem.require_paths    = ["lib"]

  gem.required_ruby_version = ">= 2.1"

  gem.add_runtime_dependency "transproc", "~> 0.2", "> 0.2.3"

  gem.add_development_dependency "hexx-rspec", "~> 0.4"
  gem.add_development_dependency "rom", "~> 0.8"

end # Gem::Specification
