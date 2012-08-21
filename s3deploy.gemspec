# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3deploy/version'

Gem::Specification.new do |gem|
  gem.name          = "s3deploy"
  gem.version       = S3deploy::VERSION
  gem.authors       = ["Christopher Lindblom"]
  gem.email         = ["chris@topher.se"]
  gem.description   = %q{Deploy static websites to Amazon S3}
  gem.summary       = %q{Deploy static websites to Amazon S3}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency("aws-s3")
end
