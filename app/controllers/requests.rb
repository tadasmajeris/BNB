class Bnb < Sinatra::Base

  get '/requests' do
    @requests_made = current_user.requests || []
    @requests_received = Request.requests_received_for(current_user)
    erb :'/requests/index'
  end

  post '/requests' do
    Request.create(user_id: current_user.id,
                  space_id: params[:space_id],
                  date: params[:date], confirmed: false)
    redirect '/requests'
  end

end
