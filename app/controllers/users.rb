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
      pony = Pony.options = { :via => :smtp,
        :via_options => { :address              => 'smtp.gmail.com',
                          :port                 => '587',
                          :enable_starttls_auto => true,
                          :user_name            => 'team3bnb',
                          :password             => 'tadantirecri',
                          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                          :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
                          } }
      p pony
      Pony.mail({:to => @user.email, :from => 'noreply@airbnb.com',
                        :subject => 'Welcome to Team3 AirBNB',
                        :body => 'Hello there. Take a look at our beautiful spaces'})

      session[:user_id] = @user.id
      redirect to '/spaces'
    else
      flash.now[:errors] = @user.errors.full_messages
    end
   erb :'/users/new'
  end

end
