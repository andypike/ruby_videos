server "127.0.0.1", :roles => %w(web app db), :user => fetch(:deploy_user), :primary => true
set :deploy_to,   "/var/apps/#{fetch(:application)}"
set :rails_env,   :production
set :ssh_options, {:forward_agent => true, :port => 2222}
