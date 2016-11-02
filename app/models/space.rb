class Space
	include DataMapper::Resource

	has n, :requests
	belongs_to :user

	property :id, Serial
	property :name, String, required: true
	property :description, Text, required: true
	property :price, Float, required: true
	property :available_from, Date, required: true
	property :available_to, Date, required: true

	def available_from_to_s
		if available_from.class == Date
			available_from.strftime("%d/%m/%Y")
		else
			available_from
		end
	end

	def available_to_to_s
		if available_to.class == Date
			available_to.strftime("%d/%m/%Y")
		else
			available_to
		end
	end

	def dates_overlap?
		if available_from.class == Date && available_to.class == Date
	 		available_to < available_from
		end
	end

	def self.available_dates(space_id)
		space = Space.first(id: space_id)
		available_dates = (space.available_from..space.available_to).map{ |date| date.strftime("%d/%m/%Y") }
		requests_made = Request.all(space_id: space_id, confirmed: true)
  	requests_made.each { |request| available_dates -= [request.date] }
		available_dates
	end
end
