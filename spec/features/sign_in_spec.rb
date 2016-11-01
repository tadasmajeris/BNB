require_relative '../spec_helper'

feature 'user can sign in' do
  scenario 'I can sign in as a registered user' do
    sign_up
    sign_in
    expect(page).to have_content('Welcome example@mail.com!')
  end
  feature 'user can sign out' do
    scenario 'As a signed in user I can sign out' do
      sign_up
      sign_in
      click_button 'Sign out'
      expect(page).not_to have_content('Welcome example@mail.com!')
    end
  end
end
