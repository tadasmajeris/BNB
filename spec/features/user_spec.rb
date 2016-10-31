require_relative '../spec_helper'

feature 'user can sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page.status_code).to eq(200)
    expect(page).to have_content('Welcome example@mail.com!')
  end
  scenario 'The user and the email given match' do
    sign_up
    expect(User.first.email).to eq('example@mail.com')
  end

  scenario 'user can not sign up if passwords do not match' do
    expect {sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
  end

  scenario 'user can not sign up with an invalid email' do
    expect {sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
  end

  scenario 'user can not sign up twice with the same email address' do
    sign_up
    expect {sign_up}.not_to change(User, :count)
    expect(page).to have_content('Email is already taken')
  end

end
