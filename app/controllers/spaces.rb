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
  							 user_id: session[:user_id],
  							 image_filepath: filenames.to_yaml)

    if @space.dates_overlap?
      flash.now[:errors] = ["Available from date must not overlap Available to date"]
  	elsif @space.save
      if params[:file]
        name = params[:name].gsub(' ','_')
      	Dir.mkdir("./app/public/imgs/#{name}")
	      filenames.each_with_index do |filename, index|
	        tempfile = tempfiles[index]
	        File.open("./app/public/imgs/#{name}/#{filename}", 'wb') do |f|
	  			  f.write(tempfile.read)
	  		  end
	      end
	    end
      session[:space_id] = @space.id
  		redirect "/spaces/#{session[:space_id]}"
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
    @images = YAML.load(@space.image_filepath) if !@space.image_filepath.nil?
    session[:space_id] = @space.id
    erb :'/spaces/book'
  end

  post '/spaces/update' do
    @space = Space.get(session[:space_id])
    filepath = ("./app/public/imgs/#{@space.name.gsub(' ','_')}")
    @space.name = params[:name] if params[:name]
    @space.description = params[:description] if params[:description]
    @space.price = params[:price_per_night] if params[:price_per_night]
    @space.available_from = params[:available_from] if params[:available_from]
    @space.available_to = params[:available_to] if params[:available_to]
    @space.save
    if params[:name]
      File.rename(filepath, "./app/public/imgs/#{@space.name.gsub(' ','_')}")
    end
    redirect '/spaces'
  end

end
