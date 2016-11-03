require 'json'

class Bnb < Sinatra::Base

  get '/requests' do
    if current_user
      @requests_made = current_user.requests || []
      @requests_received = Request.requests_received_for(current_user)
      erb :'/requests/index'
    else
      redirect '/'
    end
  end

  post '/requests' do
    @space = Space.first(id: session[:space_id])
    if Request.exists?(user_id: current_user.id,
                    space_id: session[:space_id],
                    date: params[:date])
      flash.now[:errors] = ['You have already made this request']
      erb :"/spaces/book"
    elsif Space.is_available?(id: @space.id, date: params[:date])
      r = Request.new(user_id: current_user.id,
                  space_id: @space.id,
                  date: params[:date], confirmed: false)
      redirect '/requests' if r.save
    else
      flash.now[:errors] = ['Space is not available for this date']
      erb :"/spaces/book"
    end
  end

  get '/requests/disabled_dates' do
  	dates = Space.available_dates(session[:space_id])
  	{disabledDates: dates}.to_json
  end

  get '/requests/:id' do
    if current_user
      @space_request = Request.get(params[:id])
      @spaces_booked = Request.no_of_spaces_booked(@space_request.user)
      erb :'/requests/confirm'
    else
      redirect '/'
    end
  end

  post "/requests/confirm" do
    request = Request.get(params[:request_id])
    request.update(confirmed: true)
    redirect '/requests'
  end

  delete "/requests/delete" do
    request = Request.get(params[:request_id])
    request.destroy if !request.confirmed
    redirect '/requests'
  end

end
