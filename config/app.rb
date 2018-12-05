# config/app.rb
# require_relative 'puma'

configure do
  enable :logging

  # run on puma
  set :server, :puma
  # set :bind, Proc.new { File.join(root, "/tmp/sockets/puma.socket") }
  set :bind, "unix://" + File.join(settings.root, "/tmp/sockets/puma.socket")
  puts '#' * 80
  puts settings.bind
  puts '#' * 80

  # Public dir
  # set :public_dir, ENV.fetch('PUBLIC_DIR') { Proc.new { File.expand_path("../public", root) } }
  set :public_dir, ENV.fetch('PUBLIC_DIR') { File.expand_path("../public", settings.root) }

  # Images dir
  # set :images_dir, Proc.new { File.join(public_dir, "/images") }
  set :images_dir, File.join(settings.public_dir, "/images")
  set :resources, [ 'models', 'vehicles' ]

  DATABASE = {
    adapter:  'postgres',
    hostname: ENV['DATABASE_HOSTNAME'],
    port:     ENV['DATABASE_PORT'],
    database: ENV['DATABASE_NAME'],
    username: ENV['DATABASE_USERNAME'],
    password: ENV['DATABASE_PASSWORD']
  }
  DataMapper::setup(:default, DATABASE)
end
