require 'tweetstream'
require 'colorize'

namespace :tweet do 
	desc "opens tweetstream and writes to db"
	task :fetch => [:environment] do |t|

		TweetStream.configure do |config|
		  config.consumer_key       = ENV["TWITTER_CONSUMER_KEY"]
		  config.consumer_secret    = ENV["TWITTER_CONSUMER_SECRET"]
		  config.oauth_token        = ENV["TWITTER_TOKEN"]
		  config.oauth_token_secret = ENV["TWITTER_TOKEN_SECRET"]
		  config.auth_method        = :oauth
		end

		@client = TweetStream::Client.new

		@client.on_delete do |status_id, user_id|
           Tweet.delete(status_id)
           puts "deleted".red
        end

        @client.on_scrub_geo do |up_to_status_id, user_id|
          Tweet.where(:status_id <= up_to_status_id)
          puts "scrubbed".red
    	end

    	@client.on_limit do |discarded_count|
          puts "Dicarded Count: #{discarded_count}".red
        end

        @client.on_error do |message|
			puts "Error message: #{message}".red
			@client.stop          
        end

        @client.on_no_data_received do
          puts "No data received".red
          @client.stop
        end

        @client.on_enhance_your_calm do
          puts "Account blocked".red
          @client.stop
        end

        @client.locations(-124.8,25.8,-74.4,43.3) do |status|
        	if status.is_a?(Twitter::Tweet) && status.geo.respond_to?('coordinates') && status.reply? == false && status.text.to_s.include?("home")
        		puts status.text.green
        		puts status.geo.coordinates[0]
            puts status.geo.coordinates[1]
        	 Tweet.create ({
        	 	name: status.user.name,
        	 	content: status.text,
        	 	longitude: status.geo.coordinates[0],
            latitude: status.geo.coordinates[1]
        	 	})
       		end
        end

	end
end