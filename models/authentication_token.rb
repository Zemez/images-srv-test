# user.rb
require 'rubygems'
require 'sinatra'
require 'data_mapper' # metagem, requires common plugins too.

class AuthenticationToken
  include DataMapper::Resource

  property :id, Serial, key: true
  # property :user_id, Integer
  property :body, String
  property :last_used_at, DateTime
  property :expires_in, Integer
  # property :ip_address, String
  # property :user_agent, String

  belongs_to :user
end
