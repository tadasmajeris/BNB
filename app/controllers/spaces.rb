class Bnb < Sinatra::Base

  get '/spaces' do
  	@spaces = Space.all
    erb :'/spaces/index'
  end

  post '/spaces' do
  	@space = Space.new(name: params[:name],
  							      description: params[:description],
  							      price: params[:price],
  							      available_from: params[:available_from],
  							      available_to: params[:available_to],
  							      user_id: current_user.id)
    if @space.dates_overlap?
      flash.now[:errors] = ["Available from date must not overlap Available to date"]
  	elsif @space.save
      Image.create_images(@space, params[:files])
      Mailer.space_created(current_user.email, "/spaces/#{@space.id}")
  		redirect "/spaces/#{@space.id}"
  	else
  		flash.now[:errors] = @space.errors.full_messages
  	end
  	erb :'/spaces/new'
  end

  get '/spaces/new' do
    @space = Space.new
    erb :'/spaces/new'
  end

  get '/spaces/:id' do
    @space = Space.get(params[:id])
    erb :'/spaces/book'
  end

  post '/spaces/:id' do
    @space = Space.get(params[:id])
    @space.update_space(params)
    Mailer.space_updated(current_user.email, "/spaces/#{@space.id}")
    redirect "/spaces/#{@space.id}"
  end

end
