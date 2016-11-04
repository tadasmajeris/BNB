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
      url = request.url
      url.gsub!('/users', '/spaces')
      Pony.mail(to: @user.email,
                subject: 'Welcome to Team3 AirBNB',
                body: "Hello there. Take a look at our beautiful spaces here: #{url}")
      session[:user_id] = @user.id
      redirect to '/spaces'
    else
      flash.now[:errors] = @user.errors.full_messages
    end
   erb :'/users/new'
  end

end
