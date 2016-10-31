class BNB < Sinatra::Base

  get '/sessions/new' do
    erb :'/sessions/new'
  end

end
