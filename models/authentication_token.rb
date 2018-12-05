# user.rb
require 'rubygems'
require 'sinatra'
require 'data_mapper' # metagem, requires common plugins too.

class User
  include DataMapper::Resource

  property :id, Serial, key: true
  property :user, String
  property :body, String
end
