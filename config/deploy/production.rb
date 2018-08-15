# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :branch, ENV["TRAVIS_COMMIT"] || 'production'
set :rails_env, 'production'

role :app, %w(deploy@dashboard.wikiedu.org)
role :web, %w(deploy@dashboard.wikiedu.org)
role :db,  %w(deploy@dashboard.wikiedu.org)

set :user, 'deploy'
set :address, 'dashboard.wikiedu.org'

set :deploy_to, '/var/www/dashboard'
set :rvm_type, :system
set :default_env, { 'PASSENGER_INSTANCE_REGISTRY_DIR' => '/var/www/dashboard/shared/tmp/pids' }

# This is normally set from the deploying machine's newrelic.yml.
# The ENV variable is for deployment via travis-ci.
set :newrelic_license_key, ENV['NEWRELIC_LICENSE_KEY']
set :newrelic_appname, 'Wiki Ed Dashboard'
namespace :deploy do
  after "deploy:updated", "newrelic:notice_deployment"
end
# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# server 'example.com',
# user: 'deploy',
# roles: %w{web app},
# my_property: :my_value

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
