require 'sinatra' 
require 'sinatra/reloader' if development?
require 'pp'

#set :server, 'thin'

enable :sessions             
set :session_secret, '*&(^#234a)'

chat = ['Hola']
@usuarios = []
  

get ('/') do
  erb :index
end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:alias]} : #{params['text']}"
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

post '/registro' do
  session[:alias] = params[:nombre]
  @usuarios = session[:alias]
  redirect '/'
end

get '/logout' do
  session.clear
  redirect '/'
end
