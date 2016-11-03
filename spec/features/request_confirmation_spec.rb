require 'spec_helper'

feature 'managing the requests' do

  before do
    sign_up_and_sign_in
		create_space
    save_space
    sign_out
    sign_up_and_sign_in(email: 'example2@mail.com',
                        password: 'hellomum')

    @space = Space.first
    @user2 = User.first(email: 'example2@mail.com')
    @request = Request.create(user_id: @user2.id,
                              space_id: @space.id,
                              date: Time.now.strftime("%d/%m/%Y"),
                              confirmed: false)
    sign_out
    sign_in
  end

	scenario 'can see request confirmation page' do
    visit("/requests/#{@request.id}")
    expect(page).to have_content("Request for #{@space.name}")
    expect(page).to have_content("From: #{@request.user.email}")
    expect(page).to have_content(@request.date.strftime("%d/%m/%Y"))
    expect(page).to have_content("No. of Spaces booked: 0")
    expect(page).to have_button("Confirm request from #{@request.user.email}")
    expect(page).to have_button("Deny request from #{@request.user.email}")
  end

  scenario 'can confirm the request' do
    visit("/requests/#{@request.id}")
    click_button("Confirm request from #{@request.user.email}")
    request = Request.first(user_id: @request.user.id,
                            space_id: @space.id,
                            date: @request.date.strftime("%d/%m/%Y"))
    expect(request.confirmed).to be true
  end

  scenario 'can deny the request' do
    visit("/requests/#{@request.id}")
    click_button("Deny request from #{@request.user.email}")
    request = Request.first(user_id: @request.user.id,
                            space_id: @space.id,
                            date: @request.date.strftime("%d/%m/%Y"))
    expect(request).to be nil
  end

  scenario 'after I confirmed a request the buttons should disappear' do
    visit("/requests/#{@request.id}")
    click_button("Confirm request from #{@request.user.email}")
    visit("/requests/#{@request.id}")
    expect(page).not_to have_button("Confirm request from #{@request.user.email}")
    expect(page).not_to have_button("Deny request from #{@request.user.email}")
    expect(page).to have_content("Request is confirmed")
  end

  scenario 'I can cancel my request' do
    sign_out
    sign_in(email: 'example2@mail.com',
            password: 'hellomum')
    visit('/requests')
    click_button("Cancel")
    request = Request.first(user_id: @request.user.id,
                            space_id: @space.id,
                            date: @request.date.strftime("%d/%m/%Y"))
    expect(request).to be nil
  end



end
