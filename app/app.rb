require 'sinatra/base'
require_relative 'controllers/requests'
require_relative 'controllers/sessions'
require_relative 'controllers/spaces'
require_relative 'controllers/users'

class Bnb < Sinatra::Base

  get '/' do
    redirect '/users/new'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
