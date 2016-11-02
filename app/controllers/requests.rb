require 'json'

class Bnb < Sinatra::Base

  get '/requests' do
    erb :'/requests/index'
  end

  get '/requests/disabled_dates' do
  	@requests = Request.all(:space_id => session[:space_id], :conirmed => true)
  	dates = []
  	@requests.each { |request| dates << request.date }
  	data = {disabledDates: dates}.to_json
  end

  post '/requests/create' do
  	Request.create(space_id: session[:space_id],
  								 date: params[:date])
  	redirect '/requests'
  end
end
