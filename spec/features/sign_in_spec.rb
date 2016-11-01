require_relative '../spec_helper'

feature 'user can sign in' do
  scenario 'I can sign in as a registered user' do
    sign_in
    expect(page).to have_content('Welcome example@mail.com!')
  end
end
