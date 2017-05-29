set :stage, :staging
set :branch, 'v2'

server '107.170.240.9', user: 'deploy', roles: %w{web app db}