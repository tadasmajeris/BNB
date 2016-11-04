ENV['RACK_ENV'] ||= 'development'

require_relative 'server'

class Bnb < Sinatra::Base

  get '/' do
    if current_user
      @spaces = Space.all
      erb :'/spaces/index'
    else
      redirect '/users/new'
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
