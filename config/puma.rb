# config/puma.rb
app_dir = "#{Dir.getwd}"

puts '#' * 80
puts app_dir
puts '#' * 80

# Run as daemon?
run_as_daemon = ENV.fetch('DAEMON') { false }

# Bind port?
bind_port = ENV.fetch('PORT') { false }

# Specifies the `environment` that Puma will run in.
environment ENV.fetch('APP_ENV') { 'development' }

# Logging
stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true if run_as_daemon

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port ENV['PORT'] if bind_port

# Unix socket bind
bind "unix://#{app_dir}/tmp/sockets/puma.socket"

# Set master PID and state locations
pidfile "#{app_dir}/tmp/pids/puma.pid"
state_path "#{app_dir}/tmp/pids/puma.state"

activate_control_app

# Daemonize the server into the background. Highly suggest that
# this be combined with “pidfile” and “stdout_redirect”.
# The default is “false”.
daemonize true if run_as_daemon
