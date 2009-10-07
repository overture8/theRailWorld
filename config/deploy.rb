set :rails_env, "production"

set :application, "www.therailworld.com"
set :repository,  "git@github.com:overture8/theRailWorld.git"
set :deploy_to, "/var/www/#{application}" 

set :scm, :git
ssh_options[:forward_agent] = true
set :scm_verbose, true

set :user, "root"
set :runner, user
role :web, "174.143.168.192"                          # Your HTTP server, Apache/etc
role :app, "174.143.168.192"                          # This may be the same as your `Web` server
role :db,  "174.143.168.192", :primary => true        # This is where Rails migrations will run
set :use_sudo, false

before "deploy:setup", "db:password"
after "deploy:symlink", "files:cp_database_yml"

namespace :deploy do
#  task :start {}
#  task :stop {}
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  desc "Create database password in shared path"
  task :password do
    set :db_password, Proc.new { Capistrano::CLI.password_prompt("Remote database password: ") }
    run "mkdir -p #{shared_path}/config"
    put db_password, "#{shared_path}/config/dbpassword"
  end
end

namespace :files do
  desc "Copy example database file to live database file"
  task :cp_database_yml do
    run "cp #{File.join(current_path,'config','database-example.yml')} #{File.join(current_path,'config','database.yml')}"
  end
end
