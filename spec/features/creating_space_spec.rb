require 'spec_helper'

feature 'creating a new space' do
	scenario 'providing correct details' do
		sign_up_and_sign_in
		create_space
		expect { click_button('List My Space') }.to change(Space,:count).by(1)
		expect(page).to have_content('A new space')
		expect(page).to have_content('A big and beautiful new space')
		expect(page).to have_content('23')
		expect(page).to have_content('10/11/2016')
		expect(page).to have_content('13/11/2016')
	end

	scenario 'providing incorrect details' do
		sign_up_and_sign_in
		visit('/spaces/new')
		expect{ click_button('List My Space') }.not_to change(Space,:count)
		expect(page).to have_content('Name must not be blank')
		expect(page).to have_content('Description must not be blank')
		expect(page).to have_content('Price must not be blank')
		expect(page).to have_content('Available from must not be blank')
		expect(page).to have_content('Available to must not be blank')
	end

end
