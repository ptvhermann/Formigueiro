require "rvm/capistrano"
require "bundler/capistrano"
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'deploy')
require "capistrano_database"

set :application, "oformigueiro.org"
set :repository,  "git@github.com:rscoutinho/Formigueiro.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, application                          # Your HTTP server, Apache/etc
role :app, application                        # This may be the same as your `Web` server
role :db,  application, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :branch, "master"
set :deploy_via, :remote_cache
set :user, "cap_deploy"
set :use_sudo, false
set :deploy_to, "/var/webapps/#{application}"

set :ssh_options, {:forward_agent => true}

set :shared_assets, ["public/uploads"]

namespace :deploy do
  desc "add states to database"
  task :seed_states do
   run "cd #{current_path}; bundle exec rake db:seed:state_seeds RAILS_ENV=PRODUCTION"
  end
end

namespace :assets do
  namespace :symlinks do
    desc "Setup application symlinks for shared assets"
    task :setup do
      shared_assets.each { |link| run "mkdir -p #{shared_path}/#{link}"}
    end

    desc "Link assets for current deploy to the shared location"
    task :update do
      shared_assets.each { |link| run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}" }
    end
  end
end

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 10
before "deploy:setup" do
  assets.symlinks.setup
end
after "deploy:finalize_update" do
  assets.symlinks.update
end
after "deploy:restart", "deploy:cleanup"
after 'deploy:update_code', 'deploy:migrate'
after 'deploy:migrate', 'deploy:seed_states'
# if you're still using the script/reaper helper you will need
# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
