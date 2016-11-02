require 'spec_helper'

feature 'managing the requests' do

  before do

  end

	scenario 'confirm request' do
		sign_up_and_sign_in
		create_space
    save_space
    sign_out
    sign_up_and_sign_in(email: 'example2@mail.com',
                        password: 'hellomum')

    space = Space.first
    request = Request.create(user_id: 2,
                              space_id: space.id,
                              date: Time.now.strftime("%d/%m/%Y"),
                              confirmed: false)
    visit("/requests/#{request.id}")
    expect(page).to have_content("Request for #{space.name}")
    expect(page).to have_content(request.user.email)
    expect(page).to have_content(request.date)
    # expect(page).to have_content("No. of Spaces booked: 1")
  end

end
