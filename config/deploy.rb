set :user, "dakotaleedev"
set :application, "angular_rails_receta"
set :repository,  "git@github.com:DakotaLMartinez/receta-angular-rails.git"
set :deploy_to, "/home/dakotaleedev/webapps/angular_rails_receta"
# set :default_stage, "production"
set :verbose_command_log, true
set :use_sudo, false
set :deploy_via, :checkout
set :branch, "master"

set :default_environment, {
  "PATH"      =>  "#{deploy_to}/bin:$PATH",
  "GEM_HOME"  =>  "#{deploy_to}/gems",
  "RAILS_ENV" =>  "production"
}

set :scm, :git
set :scm_username, "dakotaleemusic@gmail.com"
role :web, "dakotaleedev@dakotaleedev.webfactional.com"
role :app, "dakotaleedev@dakotaleedev.webfactional.com"
role :db,  "dakotaleedev@dakotaleedev.webfactional.com", :primary => true



desc "Restart nginx"
task :restart do 
  on roles(:app) do
    capture("#{deploy_to}/bin/restart")
  end
end

desc "Start nginx"
task :start do 
  on roles(:app) do
    capture("#{deploy_to}/bin/start")
  end
end

desc "Stop nginx"
task :stop do 
  on roles(:app) do 
    capture("#{deploy_to}/bin/stop")
  end
end



namespace :deploy do

  puts "===================================================\n"
  puts "         (  )   (   )  )"
  puts "      ) (   )  (  (         GO GRAB SOME COFFEE"      
  puts "      ( )  (    ) )\n"
  puts "     <_____________> ___    CAPISTRANO IS ROCKING!"
  puts "     |             |/ _ \\"
  puts "     |               | | |"
  puts "     |               |_| |"
  puts "  ___|             |\\___/"
  puts " /    \\___________/    \\"
  puts " \\_____________________/ \n"
  puts "==================================================="

  desc "Remake database"
  task :remakedb do 
    on roles(:db) do
      capture("cd #{deploy_to}/current; bundle exec rake db:migrate RAILS_ENV=production")
      capture("cd #{deploy_to}/current; bundle exec rake db:seed RAILS_ENV=production")
    end
  end

  desc "Seed database"
  task :seed do 
    on roles(:db) do
      capture("cd #{deploy_to}/current; bundle exec rake db:seed RAILS_ENV=production")
    end
  end

  desc "Migrate database"
  task :migrate do 
    on roles(:db) do
      capture("cd #{deploy_to}/current; bundle exec rake db:migrate RAILS_ENV=production")
    end
  end

  desc "Bundle install gems"
  task :bundle do 
    on roles(:app) do
      capture("cd #{deploy_to}/current; bundle install --deployment")
    end
  end

  namespace :assets do
    desc "Run the precompile task remotely"
    task :precompile do 
      on roles(:web), :except => { :no_release => true } do
        capture("cd #{deploy_to}/current; bundle exec rake assets:precompile RAILS_ENV=production")
      end
    end
  end

end



after "deploy:published", "deploy:bundle"
after "deploy:published", "deploy:assets:precompile"
after "deploy:published", "deploy:migrate"
after "deploy:published", "deploy:cleanup"
after "deploy:published", "restart"

# # config valid only for current version of Capistrano
# lock '3.6.0'

# set :application, 'angular_rails_receta'
# set :repo_url, 'git@github.com:DakotaLMartinez/receta-angular-rails.git'

# # Default branch is :master
# # ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# # Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/home/dakotaleedev/webapps/rails_angular_receta'

# set :default_environment, {
#   'PATH' => '#{deploy_to}/bin:$PATH',
#   'GEM_HOME' => '#{deploy_to}/gems'
# }

# set :tmp_dir, '/home/dakotaleedev/tmp'

# namespace :deploy do 
#   desc 'Restart application'
#     task :restart do 
#       on roles(:app), in: :sequence, wait: 5 do 
#         capture("#{deploy_to}/bin/restart")
#     end
#   end
# end

# namespace :gems do 
#   task :bundle do
#     run "cd #{release_path} && bundle install --deployment --without development test"
#   end
# end

# after 'deploy:publishing', 'gems:bundle'
# after 'deploy:publishing', 'deploy:restart'

# # Default value for :scm is :git
# # set :scm, :git

# # Default value for :format is :airbrussh.
# # set :format, :airbrussh

# # You can configure the Airbrussh format using :format_options.
# # These are the defaults.
# # set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# # Default value for :pty is false
# # set :pty, true

# # Default value for :linked_files is []
# # append :linked_files, 'config/database.yml', 'config/secrets.yml'

# # Default value for linked_dirs is []
# # append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# # Default value for default_env is {}
# # set :default_env, { path: "/opt/ruby/bin:$PATH" }

# # Default value for keep_releases is 5
# # set :keep_releases, 5
