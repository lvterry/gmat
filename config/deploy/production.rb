set :stage, :production
set :branch, 'master'

server '101.201.115.133', user: 'deploy', roles: %w{web app db}