# Sets up the Merb environment for Cucumber (thanks to krzys and roman)
require "rubygems"

# Add the local gems dir if found within the app root; any dependencies loaded
# hereafter will try to load from the local gems before loading system gems.
if (local_gem_dir = File.join(File.dirname(__FILE__), '..', 'gems')) && $BUNDLE.nil?
  $BUNDLE = true; Gem.clear_paths; Gem.path.unshift(local_gem_dir)
end

require "merb-core"
require "spec"
require "ruby-debug"
require "merb_cucumber/world/webrat"
require "merb_cucumber/helpers/datamapper"
require "ruby_openid_test_server/server_spec_helper"

# Configuration for ROTS
Merb::Test::World::Webrat.class_eval do
  include RubyOpenIdTestServer::ServerSpecHelper
end
Merb::Test::World::Webrat.rots_config = YAML.load(<<-CONFIG
identity: john.doe
sreg:
  nickname: jdoe
  fullname: John Doe
  email: jhon@doe.com
  dob: 1985-09-21
  gender: M
CONFIG
)
Merb::Test::World::Webrat.rots_server_options = {
  :storage => Merb.root / 'tmp' / 'rots'
}

# Uncomment if you want transactional fixtures
# Merb::Test::World::Base.use_transactional_fixtures

# Quick fix for post features running Rspec error, see 
# http://gist.github.com/37930
def Spec.run? ; true; end

Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')
  
