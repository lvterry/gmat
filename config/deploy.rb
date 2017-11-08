lock '3.6.1'

set :stages, %w(staging production)
set :default_stage, "staging"

set :application, 'gmat-rails'
set :repo_url, 'git@git.oschina.net:wangyazhou/gmat-rails.git'

set :deploy_to, '/home/deploy/gmat-rails'

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :passenger_restart_with_touch, true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end