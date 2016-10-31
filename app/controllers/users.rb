class Bnb < Sinatra::Base

  get '/users/new' do
    @user = User.new
    erb :'/users/new'

  end

  post '/users' do
    # @user = User.new
    @user = User.new(email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation])
    redirect to '/users/new'
  end


    helpers do
      def current_user
        @current_user ||= User.get(session[:user_id])
      end
    end

end
