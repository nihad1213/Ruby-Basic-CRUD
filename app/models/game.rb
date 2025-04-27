require_relative '../../config/database'

class Game
  attr_accessor :id, :title, :genre, :release_date, :rating

  def initialize(id: nil, title:, genre:, release_date:, rating:)
    @id = id
    @title = title
    @genre = genre
    @release_date = release_date
    @rating = rating
  end

  # Save game to the database
  def save
    begin
      query = <<-SQL
        INSERT INTO games (title, genre, release_date, rating)
        VALUES ('#{Database.client.escape(@title)}', '#{Database.client.escape(@genre)}', '#{@release_date}', #{@rating})
      SQL
      Database.client.query(query)
      return true
    rescue => e
      puts "Database error: #{e.message}"
      return false
    end
  end

  # List all games
  def self.all
    begin
      query = "SELECT * FROM games"
      results = Database.client.query(query)
      games = []
      results.each do |row|
        games << Game.new(
          id: row['id'],
          title: row['title'],
          genre: row['genre'],
          release_date: row['release_date'],
          rating: row['rating']
        )
      end
      games
    rescue => e
      puts "Database error: #{e.message}"
      return []
    end
  end

  # Find a game by ID
  def self.find(id)
    begin
      query = "SELECT * FROM games WHERE id = #{id}"
      result = Database.client.query(query).first
      return nil unless result

      Game.new(
        id: result['id'],
        title: result['title'],
        genre: result['genre'],
        release_date: result['release_date'],
        rating: result['rating']
      )
    rescue => e
      puts "Database error: #{e.message}"
      return nil
    end
  end

  # Update a game's details (class method)
  def self.update(id:, title:, genre:, release_date:, rating:)
    begin
      query = <<-SQL
        UPDATE games
        SET title = '#{Database.client.escape(title)}',
            genre = '#{Database.client.escape(genre)}',
            release_date = '#{release_date}',
            rating = #{rating}
        WHERE id = #{id}
      SQL
      Database.client.query(query)
      return true
    rescue => e
      puts "Database error: #{e.message}"
      return false
    end
  end

  # Delete a game by ID
  def destroy
    return false unless @id
    begin
      query = "DELETE FROM games WHERE id = #{@id}"
      Database.client.query(query)
      return true
    rescue => e
      puts "Database error: #{e.message}"
      return false
    end
  end
end