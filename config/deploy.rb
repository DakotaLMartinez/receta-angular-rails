require 'bundler/capistrano'
# config valid only for current version of Capistrano
lock '3.6.0'

require 'bundler/capistrano'

set :application, 'angular_rails_receta'
set :repo_url, 'git@github.com:DakotaLMartinez/receta-angular-rails.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/dakotaleedev/webapps/rails_angular_receta'

set :tmp_dir, '/home/dakotaleedev/tmp'

namespace :deploy do 
  desc 'Restart application'
    task :restart do 
      on roles(:app), in: :sequence, wait: 5 do 
        capture("#{deploy_to}/bin/restart")
    end
  end
end

after 'deploy:publishing', 'deploy:restart'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
