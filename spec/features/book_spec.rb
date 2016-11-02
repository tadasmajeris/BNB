require 'spec_helper'

feature 'book a space' do
	scenario 'I can see the details of a space' do
    sign_up
    sign_in
    create_space
    save_space
    visit('/spaces/1')
    expect(page).to have_content('A new space')
		expect(page).to have_content('A big and beautiful new space')
		expect(page).to have_content('23')
		expect(page).to have_content('10/11/2016')
		expect(page).to have_content('13/11/2016')
  end
end
