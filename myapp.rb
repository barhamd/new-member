require 'sinatra'
require 'haml'
require 'pony'

get '/' do
  haml :index
end

post '/submit' do
  Pony.mail :to => 'barhamd@gmail.com', :via => :smtp, :smtp => {
            :host => 'smtp.gmail.com',
            :port => 465,
            :user_name => '',
            :password => '',
            :authentication => 'plain'
            },
            :subject => 'It works!'
end
