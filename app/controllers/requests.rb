class Bnb < Sinatra::Base

  get '/requests' do
    @requests_made = current_user.requests || []
    @requests_received = Request.requests_received_for(current_user)
    erb :'/requests/index'
  end

  post '/requests' do
    if Request.exists?(user_id: current_user.id,
                    space_id: params[:space_id],
                    date: params[:date])
      flash.keep[:errors] = ['This request already exists']
      redirect "/spaces/#{params[:space_id]}"
    else
      Request.create(user_id: current_user.id,
                  space_id: params[:space_id],
                  date: params[:date], confirmed: false)
      redirect '/requests'
    end
  end
end
