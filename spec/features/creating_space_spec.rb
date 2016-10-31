require 'spec_helper'

feature 'creating a new space' do
	scenario 'providing correct details' do
		visit('/spaces/new')
		fill_in :name, with: 'A new space'
		fill_in :description, with: 'A big and beautiful new space'
		fill_in :price_per_night, with: '23'
		fill_in :available_from, with: '10/11/2016'
		fill_in :available_to, with: '13/11/2016'
		expect { click_button('List My Space') }.to change(Space,:count).by(1)
		expect(page).to have_content('A new space')
		expect(page).to have_content('A big and beautiful new space')
		expect(page).to have_content('23')
		expect(page).to have_content('10/11/2016')
		expect(page).to have_content('13/11/2016')
	end

	scenario 'providing incorrect details' do
		visit('/spaces/new')

		expect{ click_button('List My Space') }.not_to change(Space,:count)
		expect(page).to have_content('Name must not be blank')
		expect(page).to have_content('Description must not be blank')
		expect(page).to have_content('Price must not be blank')
		expect(page).to have_content('Available from must not be blank')
		expect(page).to have_content('Available to must not be blank')
	end

	scenario 'available to date cant be before available from' do

	end
end
