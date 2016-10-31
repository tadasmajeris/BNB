class BNB < Sinatra::Base

  get '/spaces' do
    erb :'/spaces/index'
  end

  get '/spaces/new' do
    erb :'/spaces/new'
  end

  get '/spaces/:id' do
    erb :'/spaces/book'
  end

end
