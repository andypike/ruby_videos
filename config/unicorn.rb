ROOT = "/var/apps/ruby_videos/current"
SHARED = "/var/apps/ruby_videos/shared"
working_directory ROOT
pid "#{SHARED}/pids/unicorn.pid"
stderr_path "#{ROOT}/log/unicorn.log"
stdout_path "#{ROOT}/log/unicorn.log"

user "deployer", "deployer"
listen "/tmp/unicorn.sock"

worker_processes (ENV["WORKERS"] && Integer(ENV["WORKERS"])) || 4
timeout 30
check_client_connection true

preload_app true
if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{ROOT}/Gemfile"
end

before_fork do |server, worker|
  old_pid = "#{SHARED}/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # something killed the old master, ignore
    end
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
