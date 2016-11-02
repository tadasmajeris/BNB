require 'json'

class Bnb < Sinatra::Base

  get '/requests' do
    @requests_made = current_user.requests || []
    @requests_received = Request.requests_received_for(current_user)
    erb :'/requests/index'
  end

  post '/requests' do
    if Request.exists?(user_id: current_user.id,
                    space_id: session[:space_id],
                    date: params[:date])
      flash.now[:errors] = ['This request already exists']
      @space = Space.first(id: session[:space_id])
      erb :"/spaces/book"
    else
      r = Request.new(user_id: current_user.id,
                  space_id: session[:space_id],
                  date: params[:date], confirmed: false)
      redirect '/requests' if r.save
    end
  end

  get '/requests/disabled_dates' do
  	dates = Space.available_dates(session[:space_id])
  	{disabledDates: dates}.to_json
  end

end
