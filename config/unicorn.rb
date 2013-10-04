worker_processes 3
timeout 30
preload_app true

@sidekiq_pid = nil

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  @sidekiq_pid ||= spawn("bundle exec bundle exec sidekiq -c 5")

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end