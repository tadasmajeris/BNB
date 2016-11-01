class Request
	include DataMapper::Resource

  belongs_to :space
  belongs_to :user

	property :id, Serial
  property :date, Date
  property :confirmed, Boolean

  def confirm_message
    confirmed ? "Confirmed" : "Not confirmed"
  end

  def self.requests_received_for(user)
    @requests = []
    @spaces = Space.all(user_id: user.id)
    @spaces.each do |space|
      @requests += Request.all(space_id: space.id)
    end
    @requests
  end
end
