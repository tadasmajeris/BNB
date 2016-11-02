def sign_up(email: 'example@mail.com',
            password: 'password',
            password_confirmation: 'password')
  visit '/users/new'
  fill_in(:email, with: email)
  fill_in(:password, with: password)
  fill_in(:password_confirmation, with: password_confirmation)
  click_button('Sign up')
end

def sign_in(email: 'example@mail.com',
            password: 'password')
  visit '/sessions/new'
  fill_in(:email, with: email)
  fill_in(:password, with: password)
  click_button('Sign in')
end

def create_space(name: 'A new space',
                  description: 'A big and beautiful new space',
                  price_per_night: '23',
                  available_from: '10/11/2016',
                  available_to: '13/11/2016')
  visit('/spaces/new')
  fill_in :name, with: name
  fill_in :description, with: description
  fill_in :price_per_night, with: price_per_night
  fill_in :available_from, with: available_from
  fill_in :available_to, with: available_to
end

def save_space
  click_button('List My Space')
end

def sign_up_and_sign_in(email: 'example@mail.com',
                        password: 'password')
  sign_up(email: email, password: password, password_confirmation: password)
  sign_in(email: email, password: password)
end

def sign_out
  click_button('Sign out')  
end
