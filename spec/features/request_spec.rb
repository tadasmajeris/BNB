describe Request do
  let(:user1) {User.create(email: 'example@mail.com',
              password: 'password',
              password_confirmation: 'password')}

  let(:user2) {User.create(email: 'mail@mail.com',
               password: 'password',
               password_confirmation: 'password')}

  let(:space) {Space.create(name: 'House',
               description: 'Nice House',
               price: '100',
               available_from: '01/12/2016',
               available_to: '01/01/2017',
               user_id: user1.id)}

  describe '.exists?' do

      it 'should return false if request doesn\'t exist' do
        expect(Request.exists?(user_id: user2.id,
                  space_id: space.id,
                  date: '15/11/2016')).to be false
      end

      it 'should return true if request already exists' do
        request = Request.create(user_id: user2.id,
                  space_id: space.id,
                  date: '15/11/2016', confirmed: false)

        expect(Request.exists?(user_id: user2.id,
                space_id: space.id,
                date: '15/11/2016')).to be true
      end
    end
  end
