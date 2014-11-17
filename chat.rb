require 'sinatra' 
require 'sinatra/reloader' if development?

set :server, 'thin'
chat = ['Hola']


get('/') do
  erb :index
end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{request.ip} : #{params['text']}"
  nil
end
#stream(:keep_open) do |out|
#    settings.connections &lt;&lt; out
#    out.callback { settings.connections.delete(out) }
#  end
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

#get '/limpiar' do
#  @updates = []
#  @last = 0
#end

