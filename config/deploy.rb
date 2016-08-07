


set :user, "dakotaleedev"
set :application, "angular_rails_receta"
set :repository,  "git@github.com:DakotaLMartinez/receta-angular-rails.git"
set :deploy_to, "/home/dakotaleedev/webapps/angular_rails_receta"
set :default_stage, "production"
set :verbose_command_log, true
set :use_sudo, false
set :deploy_via, :checkout
set :branch, "master"

set :default_environment, {
  "PATH"      =>  "#{deploy_to}/bin:$PATH",
  "GEM_HOME"  =>  "#{deploy_to}/gems",
  "RAILS_ENV" =>  "#{default_stage}"
}

set :scm, :git
set :scm_username, "dakotaleemusic@gmail.com"
role :web, "dakotaleedev@dakotaleedev.webfactional.com"
role :app, "dakotaleedev@dakotaleedev.webfactional.com"
role :db,  "dakotaleedev@dakotaleedev.webfactional.com", :primary => true



desc "Restart nginx"
task :restart do
  run "#{deploy_to}/bin/restart"
end

desc "Start nginx"
task :start do
  run "#{deploy_to}/bin/start"
end

desc "Stop nginx"
task :stop do
  run "#{deploy_to}/bin/stop"
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
    run "cd #{deploy_to}/current; bundle exec rake db:migrate RAILS_ENV=#{default_stage}"
    run "cd #{deploy_to}/current; bundle exec rake db:seed RAILS_ENV=#{default_stage}"
  end

  desc "Seed database"
  task :seed do
    run "cd #{deploy_to}/current; bundle exec rake db:seed RAILS_ENV=#{default_stage}"
  end

  desc "Migrate database"
  task :migrate do
    run "cd #{deploy_to}/current; bundle exec rake db:migrate RAILS_ENV=#{default_stage}"
  end

  desc "Bundle install gems"
  task :bundle do
    run "cd #{deploy_to}/current; bundle install --deployment"
  end

  namespace :assets do
    desc "Run the precompile task remotely"
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run "cd #{deploy_to}/current; bundle exec rake assets:precompile RAILS_ENV=#{default_stage}"
    end
  end

end



after "deploy", "deploy:bundle"
after "deploy", "deploy:assets:precompile"
after "deploy", "deploy:migrate"
after "deploy", "deploy:cleanup"
after "deploy", "restart"

#