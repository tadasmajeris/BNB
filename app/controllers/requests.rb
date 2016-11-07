require 'json'

class Bnb < Sinatra::Base

  get '/requests' do
    if current_user
      @requests_made = current_user.requests || []
      @requests_received = current_user.requests_received
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
      request = Request.new(user_id: current_user.id,
                  space_id: @space.id,
                  date: params[:date], confirmed: false)
      if request.save
        owner = User.get(@space.user_id)
        Mailer.space_requested(owner.email, request)
        Text.send(owner.phone_number,"You just recieved a request to rent #{@space.name} by #{current_user.email}") if owner.has_a_phone_number?
        redirect '/requests'
      end
    else
      flash.now[:errors] = ['Space is not available for this date']
      erb :"/spaces/book"
    end
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
    Mailer.space_confirmed(request.user.email, request.space.name, request.date.strftime("%d/%m/%Y"))
    Text.send(request.user.phone_number,"#{current_user.email} just confirmed your request to rent #{request.space.name} on #{request.date}") if request.user.has_a_phone_number?
    redirect '/requests'
  end

  delete "/requests/delete" do
    request = Request.get(params[:request_id])
    unless request.confirmed
      Mailer.space_denied(request.user.email, request.space.name, request.date.strftime("%d/%m/%Y"))
      Text.send(request.user.phone_number,"#{current_user.email} just denied your request to rent #{request.space.name} on #{request.date}") if request.user.has_a_phone_number?
      request.destroy
    end
    redirect '/requests'
  end

end
