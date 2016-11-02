require 'json'

class Bnb < Sinatra::Base

  get '/requests' do
    erb :'/requests/index'
  end

  get '/requests/disabled_dates' do
  	data = {disabledDates: ["21-11-2016", "22-11-2016", "23-11-2016", "26-11-2016"]}.to_json
  end

  post '/requests/create' do
  	p params[:date]
  end

end
