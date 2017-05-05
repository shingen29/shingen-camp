# ワーカーの数
worker_processes 2

# root
root = File.expand_path('../../', __FILE__)
working_directory root

# ソケット
listen "#{root}/tmp/sockets/unicorn.sock"
pid "#{root}/tmp/pids/unicorn.pid"

# ログ
stderr_path "#{root}/log/unicorn_error.log"
stdout_path "#{root}/log/unicorn.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

old_pid = "#{ server.config[:pid] }.oldbin"
unless old_pid == server.pid
  begin
   sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
   Process.kill :QUIT, File.read(old_pid).to_i
   rescue Errno::ENOENT, Errno::ESRCH
  end
end
end

after_fork do |server, worker|
    defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
