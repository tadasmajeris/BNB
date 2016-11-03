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
	property :image_filepath, Text

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

	def save_images(filenames,tempfiles,space_id)
    filenames.each_with_index do |filename, index|
        tempfile = tempfiles[index]
        File.open("./app/public/imgs/#{space_id}/#{filename}", 'wb') do |f|
          f.write(tempfile.read)
        end
    end
  end

	def update_space(params)
		self.update(name: params[:name]) if params[:name]
    self.update(description: params[:description]) if params[:description]
    self.update(price: params[:price_per_night]) if params[:price_per_night]
    self.update(available_from: params[:available_from]) if params[:available_from]
    self.update(available_to: params[:available_to]) if params[:available_to]
    if params[:file]
      filenames = params[:file].map{ |f| f[:filename]}
      tempfiles = params[:file].map{ |f| f[:tempfile]}
      current_filepath = YAML.load(self.image_filepath)
      new_filepath = current_filepath + filenames
      self.update(image_filepath: new_filepath.to_yaml)
      self.save_images(filenames,tempfiles,self.id)
    end
  end
end
