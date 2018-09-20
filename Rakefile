require_relative './config/environment'

def reload!
    load_all './lib'
end

task :console do
    Pry.start
end

task :scrape_rooms do
    #instantiate a scraper and have it find new rooms
    ftw_scraper = RoomScraper.new('https://dallas.craigslist.org/search/ftw/roo')
    # ftw_scraper.call
    # chicago_scraper =RoomScraper.new('https://chicago.craigslist.org/search/roo')
    # chicago_scraper.call
     # after this method call we should be able to say Room.all and have rooms
end
