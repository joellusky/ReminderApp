namespace :provider do


	task dump: :environment do
		provider = Provider.all
  	
    provider.each do |p|
    	puts "Provider.find_or_create_by(name: #{p.name.inspect}).update_attributes(category: categories[#{p.category.name.inspect}], url: #{p.url.inspect})"

    	end
	end
end