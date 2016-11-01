require 'json'

class Bnb < Sinatra::Base

  get '/requests' do
    erb :'/requests/index'
  end

  get '/requests/example' do
  	data = {disabledDates: ["21-11-2016", "22-11-2016", "23-11-2016", "24-11-2016"]}.to_json
  end

  post '/requests/example' do
  	p params[:date]
  end

end
