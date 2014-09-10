namespace :provider do


	task dump: :environment do
		provider = Provider.all
  	#   t.integer  "category_id"
    # t.string   "name"
    # t.string   "url"
    # Provider.find_or_create_by(name: 'FPL').update_attributes(category: categories['Electric'], url: 'http://fpl.com')
    provider.each do |p|
    	puts "Provider.find_or_create_by(name: #{p.name.inspect}).update_attributes(category: categories[#{p.category.name.inspect}], url: #{p.url.inspect})"

    	end
	end
end