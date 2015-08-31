# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'mikanz'
set :repo_url, 'git@github.com:a-know/mikan.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/mikanz-test'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, (fetch(:linked_dirs) + ['tmp/pids'])

# Unicorn
set :unicorn_rack_env, 'none'
set :unicorn_config_path, 'config/unicorn.rb'

# Default value for default_env is {}
set :default_env, {
  rbenv_root: '/usr/local/rbenv',
  path: '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH'
}

set :rails_env, :iaas

# Default value for keep_releases is 5
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :restart do
    invoke 'unicorn:restart'
  end

end
