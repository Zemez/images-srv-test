# app.rb
require 'rubygems'
require 'bundler/setup' # If you're using bundler, you will need to add this
require 'dotenv/load'
require 'sinatra'
require 'data_mapper' # requires all the gems listed above
require 'yajl'
require 'fileutils'
#
require_relative 'config/app'
require_relative 'models/user'
require_relative 'models/authentication_token'
#
# include FileUtils::Verbose
get '/' do
  redirect to('/images')
end

get '/users' do
  users = User.all
  logger.info '#' * 80
  logger.info users.map { |u| u.as_json }
  logger.info '#' * 80
  # Yajl::Encoder.encode(users)
  users.to_json
end

get '/tokens' do
  users = User.all
  user_tokens = users.map do |user|
    user.as_json.merge(tokens: user.authentication_tokens)
  end
  user_tokens.to_json
end

# вывести весь список картинок
get '/images' do
  images_list = Dir.glob(settings.images_dir + '/**/*.{png,jpg,jpeg,gif,svg}').map { |f| f.gsub(settings.public_dir, '') }
  images_sub = settings.images_dir.gsub(settings.public_dir, '') + '/'
  images = images_list.map do |image_path|
    arr = image_path.gsub(images_sub, '').split('/')
    {
      resource: arr.size >=2 && arr[0].is_a?(String) && settings.resources.include?(arr[0]) ? arr[0] : nil,
      resource_id: arr.size >= 3 && arr[1].to_i > 0 ? arr[1].to_i : nil,
      image_path: image_path
    }
  end
  images.to_json
end

get '/images/:resource/:id/upload' do
  erb :upload, locals: { action: "/images/#{params[:resource]}/#{params[:id]}/upload" }
end

post '/images/:resource/:id/upload' do
  tempfile = params[:file][:tempfile] 
  filename = params[:file][:filename] 
  target_dir = File.join(settings.images_dir, "/#{params[:resource]}/#{params[:id]}") if settings.resources.include?(params[:resource])
  FileUtils.mkdir_p(target_dir) unless File.exists?(target_dir)
  FileUtils.cp(tempfile.path, File.join(target_dir, "/#{filename}"))
  { message: 'Готово!' }.to_json
end
