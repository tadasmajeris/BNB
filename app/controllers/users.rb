class Bnb < Sinatra::Base

  get '/users/new' do
    @user = User.new
    erb :'/users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation])
    if @user.password.empty?
      flash.now[:errors] = ["Password must not be blank"]
    elsif @user.save
      Mailer.new.send_welcome(@user.email, '/spaces')
      session[:user_id] = @user.id
      redirect to '/spaces'
    else
      flash.now[:errors] = @user.errors.full_messages
    end
   erb :'/users/new'
  end

end
