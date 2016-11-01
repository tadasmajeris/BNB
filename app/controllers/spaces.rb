class Bnb < Sinatra::Base

  get '/spaces' do
  	@spaces = Space.all
    erb :'/spaces/index'
  end

  post '/spaces' do
  	@space = Space.new(name: params[:name],
  							 description: params[:description],
  							 price: params[:price_per_night],
  							 available_from: params[:available_from],
  							 available_to: params[:available_to])
    
    if @space.available_from.class == Date && @space.available_to.class == Date && @space.available_to < @space.available_from
      flash.now[:errors] = ["Available from date must not overlap Available to date"]
  	elsif @space.save
  		redirect '/spaces'
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
    erb :'/spaces/book'
  end

end
