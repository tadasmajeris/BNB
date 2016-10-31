class Bnb < Sinatra::Base

  get '/requests' do
    erb :'/requests/index'
  end

end
