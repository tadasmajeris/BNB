class Bnb < Sinatra::Base

  get '/payment' do
    erb :'charge/index'
  end

  post '/charge' do
    @amount = 1

  customer = Stripe::Customer.create(
    :email => 'crispin.andrews@gmail.com',
    :source  => params[:stripeToken]
    )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
    )

    erb :'charge/confirmation'
  end

  error Stripe::CardError do
    env['sinatra.error'].message
  end
end
