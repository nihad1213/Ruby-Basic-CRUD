require_relative '../config/database'

class CreateGamesTable
    def self.up
        client = Database.client()
        
        query = <<-SQL
          CREATE TABLE IF NOT EXISTS games (
            id INT AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(255) NOT NULL,
            genre VARCHAR(255),
            release_date DATE,
            rating DECIMAL(3, 2),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
          );
        SQL

        client.query(query)
        puts "Game table is created successfully"
    end

    def self.down
        client = client

        query = "DROP TABLE IF EXISTS games"
        client.query.(query)

        puts "Games table dropped successfully"
    end
end