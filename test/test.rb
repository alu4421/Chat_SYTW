require 'coveralls'
Coveralls.wear!

require_relative '../chat.rb'
ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'rubygems'
require 'rspec'

include Rack::Test::Methods

describe "Test Chatina" do
   
	def app
	  Sinatra::Application
	end
   
	it "Pagina Principal" do
	  get '/'
	  expect(last_response).to be_ok
   end

   it "Poder enviar" do
	  get '/send'
	  expect(last_response.body).to eq("Not an ajax request")
   end

   it "Poder Logearse" do
	  get '/registro'
	  expect(last_response).to be_ok
   end
end