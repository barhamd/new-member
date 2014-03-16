require 'sinatra'
require 'haml'
require 'pony'

get '/' do
  haml :index
end

post '/submit' do
  Pony.mail({
    :to => ENV['TO_EMAIL'],
    :via => :smtp,
    :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => ENV['FROM_EMAIL'],
      :password             => ENV['FROM_EMAIL_PASSWORD'],
      :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
      :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
    }
  })

  haml :submit
end
