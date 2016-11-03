require 'json'

class Bnb < Sinatra::Base

  get '/requests' do
    @requests_made = current_user.requests || []
    @requests_received = current_user.requests_received
    erb :'/requests/index'
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
    p dates
  	{disabledDates: dates}.to_json
  end

  get '/requests/:id' do
    @space_request = Request.get(params[:id])
    @spaces_booked = Request.no_of_spaces_booked(@space_request.user)
    erb :'/requests/confirm'
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
