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
        <li><b>First Name:</b> #{params[:first_name]}</li>
        <li><b>Last Name:</b> #{params[:last_name]}</li>
        <li><b>Phone:</b> #{params[:phone]}</li>
        <li><b>Email:</b> #{params[:email]}</li>
        <li><b>Address:</b> #{params[:address]}</li>
        <li><b>Emergency Contact:</b> #{params[:emergency_contact]}</li>
        <li><b>Emergency Contact Phone:</b> #{params[:emergency_contact_phone]}</li>
        <li><b>Relationship:</b> #{params[:relationship]}</li>
        <li><b>Preferred ID:</b> #{params[:preferred_id]}</li>
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

  @first_name = params[:first_name]
  haml :submit
end
