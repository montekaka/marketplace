require 'feedzirra'
require 'nokogiri'

	desc "update rss from dealnews"
	task :dealnews => :environment do

		# fetching a single feed
	  	#feed = Feedzirra::Feed.fetch_and_parse("http://s31.dlnws.com/dealnews/rss/popular.xml")
	  	feed = Feedzirra::Feed.fetch_and_parse("http://s31.dlnws.com/dealnews/rss/todays-edition.xml")

		# feed and entries accessors
		# puts feed.title          # => "Paul Dix Explains Nothing"
		# puts feed.url            # => "http://www.pauldix.net"
		# puts feed.feed_url       # => "http://feeds.feedburner.com/PaulDixExplainsNothing"
		# puts feed.etag           # => "GunxqnEP4NeYhrqq9TyVKTuDnh0"
		# puts feed.last_modified  # => Sat Jan 31 17:58:16 -0500 2009 # it's a Time object

		user = User.find_by_id(1)
		if user == nil
			user = User.create(:email=>"a@a.com", :password=>"11111111")
		end

		feed.entries.each do |entry|
			#puts 'title: ' + entry.title      # => "Ruby Http Client Library Performance"
			#puts 'url: ' + entry.url        # => "http://www.pauldix.net/2009/01/ruby-http-client-library-performance.html"
			#puts 'author ' + entry.author     # => "Paul Dix"
			#puts 'summary ' + entry.summary.sanitize    # => "..."
			#puts 'content ' + entry.content    # => "..."
			#puts entry.published  # => Thu Jan 29 17:00:19 UTC 2009 # it's a Time object
			#puts 'categories ' + entry.categories # => ["...", "..."]

			#parse to get the image from the link
			puts "the url is " + entry.url
			doc = Nokogiri::HTML(open(entry.url))
			items = doc.css('.leftCol .image img')
			if items.count != 0
				image_url = items.first['src']

				# for testing only	
				# get a random category 
				category_count = Pin::CATEGORY_TYPE.count
				random_category_index = rand(0..category_count)
				puts random_category_index

				# put inside database
				user.pins.create(:title=>entry.title, :image=>URI.parse(image_url), :category=>Pin::CATEGORY_TYPE[random_category_index])
			end
		end



		
end