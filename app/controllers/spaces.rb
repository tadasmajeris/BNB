require 'yaml'

class Bnb < Sinatra::Base

  get '/spaces' do
  	@spaces = Space.all
    erb :'/spaces/index'
  end

  post '/spaces' do
    if params[:file]
    	filenames = params[:file].map{ |f| f[:filename]}
      tempfiles = params[:file].map{ |f| f[:tempfile]}
    else
    	filenames = []
    end

  	@space = Space.new(name: params[:name],
  							 description: params[:description],
  							 price: params[:price_per_night],
  							 available_from: params[:available_from],
  							 available_to: params[:available_to],
  							 user_id: current_user.id,
  							 image_filepath: filenames.to_yaml)

    if @space.dates_overlap?
      flash.now[:errors] = ["Available from date must not overlap Available to date"]
  	elsif @space.save
      create_directory("./app/public/imgs/#{@space.id}")
	    @space.save_images(filenames,tempfiles,@space.id) if params[:file]
      session[:space_id] = @space.id
      Mailer.new.space_created(current_user.email, "spaces/#{@space.id}")
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
    @images = YAML.load(@space.image_filepath) unless @space.image_filepath.nil?
    session[:space_id] = @space.id
    erb :'/spaces/book'
  end

  post '/spaces/update' do
    @space = Space.get(session[:space_id])
    old_name = @space.name.gsub(" ","_")
    filepath = "./app/public/imgs/#{@space.id}"
    @space.update_space(params)

    redirect "/spaces/#{@space.id}"
  end

end
