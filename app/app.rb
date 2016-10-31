ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
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

  get '/' do
    redirect '/users/new'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
