$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_login_smsable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_login_smsable"
  s.version     = DeviseLoginSmsable::VERSION
  s.authors     = ["Maxim"]
  s.email       = ["maxx11@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "SMS or IP authentication"
  s.description = "Description goes here"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  #s.files = Dir["**/*"] - Dir["*.gem"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "devise", "~> 1.5.3"
end
