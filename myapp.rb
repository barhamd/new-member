require 'sinatra'
require 'haml'
require 'pony'

get '/' do
  haml :index
end

post '/submit' do
  Pony.mail({
    :to => ENV['TO_EMAIL'],
    :subject => 'Potential Member Info!',
    :html_body => "
      <h1> Here's the info!</h1>
      <ul>
        <li>First Name: #{params[:first_name]}</li>
        <li>Last Name: #{params[:last_name]}</li>
        <li>Phone: #{params[:phone]}</li>
        <li>Email: #{params[:email]}</li>
        <li>Address: #{params[:address]}</li>
        <li>Emergency Contact: #{params[:emergency_contact]}</li>
        <li>Emergency Contact Phone: #{params[:emergency_contact_phone]}</li>
        <li>Relationship: #{params[:relationship]}</li>
        <li>Preferred ID: #{params[:preferred_id]}</li>
      </ul>
    ",
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
