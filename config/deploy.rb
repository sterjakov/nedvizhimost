ssh_options[:forward_agent] = false
#default_run_options[:pty] = true
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Это указание на то, какой Ruby интерпретатор мы будем использовать.
set :application, "nedwizhimostwmoskwe.ru"
set :repository,  "sterjakov@178.63.209.221:~/git/nedwizhimostwmoskwe.git"
set :default_stage, "production"
set :use_sudo, false
set :user, 'sterjakov'
set :scm, :git
set :normalize_asset_timestamps, false
set :rails_env, 'production'
set :branch, 'master'
set :deploy_to, "/home/sterjakov/ruby-sites/#{application}"
set :keep_releases, 1



namespace :deploy do
  desc "Create symlinks"
  task :create_symlinks do
    # Для фотографий
    run "ln -nfs #{shared_path}/public/uploads #{latest_release}/public/uploads"
    # Конфиг БД
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config"
  end

  desc "Restart unicorn"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run ". /home/sterjakov/restart.sh"
  end

#  desc "Install gems"
#  task :bundle_new_release, :roles => :app do
#    run "cd #{latest_release} && bundle install"
#  end

end

after "deploy:update_code", "deploy:create_symlinks"
# after "deploy:update_code", "deploy:bundle_new_release"

after "deploy:update", "deploy:cleanup"

server '178.63.209.221', :web, :app, :db, :primary => true


