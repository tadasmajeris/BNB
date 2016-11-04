class Image
	include DataMapper::Resource

  belongs_to :space

	property :id, Serial
	property :url, String

	def self.create_images(space, files)
    Dir.mkdir("./app/public/imgs/#{space.id}") unless Dir.exists?("./app/public/imgs/#{space.id}")

		if files
    	filenames = files.map{ |f| f[:filename]}
      tempfiles = files.map{ |f| f[:tempfile]}
			self.save_images(filenames, tempfiles, space.id)
    end
	end

	def self.save_images(filenames, tempfiles, space_id)
		image_count = Space.get(space_id).images.count || 0
		index = image_count
    filenames.each_with_index do |filename, i|
			ext = File.extname(filename)
			new_name = index.to_s + ext # 0.jpg, 1.jpg, etc...
			url = "/imgs/#{space_id}/#{new_name}"

			tempfile = tempfiles[i]
      File.open("./app/public#{url}", 'wb') do |f|
        f.write(tempfile.read)
      end

			Image.create(url: url, space_id: space_id)
			index += 1
    end
  end
end
