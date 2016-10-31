class Bnb < Sinatra::Base

  get '/spaces' do
  	@spaces = Space.all
    erb :'/spaces/index'
  end

  post '/spaces' do
  	space = Space.new(name: params[:name], 
  							 description: params[:description],
  							 price: params[:price_per_night],
  							 available_from: params[:available_from],
  							 available_to: params[:available_to])
  	space.save
  	redirect '/spaces'
  end

  get '/spaces/new' do
    erb :'/spaces/new'
  end

  get '/spaces/:id' do
    erb :'/spaces/book'
  end

end
