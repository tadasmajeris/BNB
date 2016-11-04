class Bnb < Sinatra::Base

  post '/payment' do
    @amount = Request.get(params[:request_id])
    session[:amount] = @amount.space.price
    redirect '/payment'
  end

  get '/payment' do
    @amount = session[:amount]
    erb :'charge/index'
  end

  post '/charge' do

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :source  => params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      :amount      => @amount,
      :description => 'Sinatra Charge',
      :currency    => 'usd',
      :customer    => current_user.id
      )

    erb :'charge/confirmation'
  end

  error Stripe::CardError do
    env['sinatra.error'].message
  end
end
