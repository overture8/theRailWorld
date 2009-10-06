class TwitterTickerGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      
      twitter_ticker_images_dir = File.join("public", "images", "twitter_ticker")
      m.directory twitter_ticker_images_dir
      
      m.file  "stylesheets/twitter_ticker.css", 'public/stylesheets/twitter_ticker.css'
      m.file  "javascripts/twitter_ticker.js", 'public/javascripts/twitter_ticker.js'
      m.file  "images/twitterTabBg.png", "public/images/twitter_ticker/twitterTabBg.png"
      m.file  "images/twitterTickerTab.png", "public/images/twitter_ticker/twitterTickerTab.png"

    end
  end
end
