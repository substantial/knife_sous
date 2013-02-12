require 'bundler'
Bundler.setup

SPEC_ROOT = File.dirname(__FILE__)

RSpec.configure do |config|
  config.mock_with :rspec
end

require File.join(SPEC_ROOT, '/../lib/knife_sous')

Dir[File.join(SPEC_ROOT, 'support', '*.rb')].each{ |file| require file }
Dir[File.join(SPEC_ROOT, 'support', 'shared_examples', '*.rb')].each{ |file| require file }

