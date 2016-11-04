class Space
	include DataMapper::Resource

	has n, :requests
	has n, :images
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
  	requests_made.each { |request| available_dates -= [request.date.strftime("%d/%m/%Y")] }
		available_dates
	end

	def self.is_available?(id: '', date: '')
		self.available_dates(id).include?(date)
	end

	def update_space(params)
		new_params = {}

		params.each do |k, v|
			if self.respond_to?(k)
				value_in_db = self.send(k)

				if (value_in_db.class == Date && value_in_db.strftime("%d/%m/%Y") != v) || value_in_db.to_s != v
					new_params[k] = v
				end
			end
		end

		self.update(new_params)
		Image.create_images(self, params[:files]) if params[:files]
  end
end
