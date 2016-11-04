ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require 'pony'
require_relative 'controllers/requests'
require_relative 'controllers/sessions'
require_relative 'controllers/spaces'
require_relative 'controllers/users'
require_relative 'data_mapper_setup'

class Bnb < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__))
  set :views, Proc.new { File.join(root, "views") }

  use Rack::MethodOverride
  register Sinatra::Flash
  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    if current_user
      @spaces = Space.all
      erb :'/spaces/index'
    else
      redirect '/users/new'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end

    def not_sign_in_page
      request.path_info != '/sessions/new'
    end

    def create_directory(dirname)
      Dir.mkdir(dirname)
    end


  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
