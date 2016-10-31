class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation
  
  property :id, Serial
  property :email, String
  property :password, Text

end
