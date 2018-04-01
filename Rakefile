def default_host
  ENV['host'] || '0.0.0.0'
end

def default_port
  ENV['port'] || '9001'
end

def default_rack_config
  ENV['rack_config'] || 'api/config.ru'
end

def default_library_dir
  ENV['library'] || './lib'
end

task 'server' do
  puts "Starting server: http://#{default_host}:#{default_port}/"
  start_cmd = "rackup -I #{default_library_dir} --port #{default_port} --host #{default_host} #{default_rack_config}"
  sh start_cmd
end
