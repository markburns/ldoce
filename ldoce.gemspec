# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ldoce/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mark Burns"]
  gem.email         = ["markthedeveloper@gmail.com"]
  gem.description   = %q{API for the Longman Dictionary of Contemporary English}
  gem.summary       = %q{So far covers playing mp3 media files and fetching definitions}
  gem.homepage      = "https://github.com/markburns/ldoce"

  gem.add_dependency 'httparty'


  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "ldoce"
  gem.require_paths = ["lib"]
  gem.version       = Ldoce::VERSION
end
