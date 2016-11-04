require 'sinatra/base'
require 'sinatra/flash'
require 'pony'
require_relative 'models/mailer'
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

  Pony.options = {:via => :smtp,
                  :via_options =>
                  { :address              => 'smtp.gmail.com',
                    :port                 => '587',
                    :enable_starttls_auto => true,
                    :user_name            => 'team3bnb',
                    :password             => 'tadantirecri',
                    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
                  }
                }


  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end

    def not_sign_in_page
      request.path_info != '/sessions/new'
    end
  end
end
