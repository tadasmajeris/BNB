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
    request.destroy
    redirect '/requests'
  end

end
