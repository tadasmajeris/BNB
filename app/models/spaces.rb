class Space
	include DataMapper::Resource

	property :id, Serial
	property :name, String, required: true
	property :description, Text, required: true
	property :price, Float, required: true
	property :available_from, Date, required: true
	property :available_to, Date, required: true

	def available_from_to_s
		if !self.errors.full_messages.include?('Available from must be of type Date') && available_from
			available_from.strftime("%d/%m/%Y")
		else
			available_from
		end
	end

	def available_to_to_s
		if !self.errors.full_messages.include?('Available to must be of type Date')  && available_to
			available_to.strftime("%d/%m/%Y")
		else
			available_to
		end
	end
end
