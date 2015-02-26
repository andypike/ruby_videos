set :application,      "ruby_videos"
set :deploy_user,      "deployer"
set :default_shell,    "/bin/bash -l"
set :deploy_via,       "remote_cache"
set :bundle_without,   [:darwin, :development, :test]
set :scm,              "git"
set :repo_url,         "git@github.com:andypike/ruby_videos.git"
set :branch,           "master"
set :deploy_via,       :remote_cache
set :pty,              true
set :keep_releases,    5
set :rbenv_ruby,       "2.1.5"
set :linked_files,     %w(config/database.yml)
set :linked_dirs,      %w(log)

namespace :deploy do
  desc "Restart application"
  task :restart do
    on roles(:app), :in => :sequence, :wait => 5 do
      execute :kill, "-s USR2", "`cat #{shared_path}/pids/unicorn.pid`"
    end
  end

  desc "Start unicorn"
  task :start do
    on roles(:app), :in => :sequence, :wait => 5 do
      within current_path do
        execute :bundle, "exec unicorn", "-c", "config/unicorn.rb", "-E", fetch(:rails_env), "-D"
      end
    end
  end

  desc "Stop unicorn"
  task :stop do
    on roles(:app), :in => :sequence, :wait => 5 do
      execute :kill, "-s QUIT", "`cat #{shared_path}/pids/unicorn.pid`"
    end
  end

  desc "Run the seeds"
  task :seed do
    on roles(:app), :in => :sequence, :wait => 5 do
      within current_path do
        execute :bundle, "exec rake db:seed RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end

  after :finishing, "deploy:cleanup"
  after :finished,  "deploy:restart"
end
