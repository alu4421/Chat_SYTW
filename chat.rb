require 'sinatra' 
require 'sinatra/reloader' if development?
require 'pp'

set :server, 'thin'
chat = ['Hola']

  enable :sessions               
  set :session_secret, '*&(^#234a)'

get('/') do
 #if session[:auth_] then
    
  #else
    
  #end
  erb :index
end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:nombre]} : #{params['text']}"
  nil
end

get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []
  @last = chat.size
  erb <<-"HTML"
      <% @updates.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
      <span data-last="<%= @last %>"</span>

  HTML
end

get '/logout' do
  session.clear
  redirect '/'
end
