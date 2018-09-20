class RoomScraper

    def initialize(index_url)
        @index_url = index_url
        @doc = Nokogiri::HTML(open(index_url))
    end

    def call
        rows.each do |row_doc|
            # room = scrape_row(row_doc)
            # # room.save
            Room.create_from_hash(scrape_row(row_doc)) #injects room into DB
        end
    end

    private 
    
    def rows
        @rows ||= @doc.search("div.content li.result-row")
    end

    def scrape_row(row)
        #scrape an individual row
        {
        :date_created => row.search("time.result-date").text,
        :title => row.search("a.result-title.hdrlnk").text,
        :url => row.search('a.result-title.hdrlnk').attribute('href').text,
        :price => row.search("span.result-meta span.result-price").text,
        :sqfootage => row.search("span.result-meta span.housing").text.strip.gsub(" -", "")
        }
    end
end
