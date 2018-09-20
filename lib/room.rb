class Room
    attr_accessor :id, :title, :date_created, :price, :url, :sqfootage

    def self.create_table
        sql = <<-SQL
            CREATE TABLE IF NOT EXISTS rooms (
                id INTEGER PRIMARY KEY,
                title TEXT,
                date_created DATETIME,
                price TEXT,
                sqfootage TEXT,
                url TEXT
            )
            SQL
        DB[:conn].execute(sql)
    end

    def self.create_from_hash(hash) #instantiate and save
        new_from_hash(hash).save
    end

    def self.create_from_db(row)
        new_from_db(row).save
    end

    def self.new_from_hash(hash) #instantiate
        Room.new.tap do |new_room|
            new_room.title = hash[:title]
            new_room.date_created = hash[:date_created]
            new_room.price = hash[:price]
            new_room.sqfootage = hash[:sqfootage]
            new_room.url = hash[:url]
        end
    end

    def self.new_from_db(row)
        Room.new.tap do |new_room|
            new_room.id = row[0]
            new_room.title = row[1]
            new_room.date_created = row[2]
            new_room.price = row[3]
            new_room.sqfootage = row[4]
            new_room.url = row[5]
        end
    end

    def insert
        puts "Saving #{self} to database."
        if self.id != nil
            self.update
        else
            sql = <<-SQL
                INSERT INTO rooms (title, date_created, price, sqfootage, url)
                VALUES (?, ?, ?, ?, ?)
            SQL

            DB[:conn].execute(sql, self.title, self.date_created, self.price, self.sqfootage, self.url)
        end
    end

    def update
        sql = <<-SQL
            UPDATE rooms
            SET title = ?, date_created = ?, price = ?, sqfootage = ?, url = ?
            WHERE id = ?
        SQL

        DB[:conn].execute(sql, self.title, self.date_created, self.price, self.sqfootage, self.url, self.id)
    end

    def save
        insert
    end

    def self.find_by_id(num)
        sql = <<-SQL
        SELECT *
        FROM rooms
        WHERE id = ?
        SQL

        DB[:conn].execute(sql, num)
    end

    def self.by_price(order = "ASC")
        sql = <<-SQL
        SELECT * 
        FROM rooms 
        ORDER BY price #{order}
        SQL
        
        rows = DB[:conn].execute(sql)
        self.new_from_db(rows)
    end

    def self.by_sqfootage(order = "DESC")
        sql = <<-SQL
        SELECT * 
        FROM rooms 
        ORDER BY sqfootage #{order}
        SQL

        DB[:conn].execute(sql)
    end

    def self.all
        sql = <<-SQL
        SELECT * FROM rooms;
        SQL

        rows = DB[:conn].execute(sql)

        rows.collect do |row|
            self.new_from_db(row)
        end
    end

    def self.destroy_table
        sql = <<-SQL
        DROP TABLE rooms
        SQL

        DB[:conn].execute(sql)
    end
end
