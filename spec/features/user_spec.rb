require_relative '../spec_helper'

feature 'user can sign up' do
  scenario 'I can sign up as a new user' do
    sign_up
    expect(page.status_code).to eq(200)
    expect(page).to have_content('Welcome example@mail.com!')
    expect { sign_up }.to change(User, :count).by(1)
  end
end
