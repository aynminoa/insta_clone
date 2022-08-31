server '52.196.191.146', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/ayumi/.ssh'