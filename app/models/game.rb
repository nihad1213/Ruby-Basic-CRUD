# models/game.rb
require_relative '../config/database'

class Game
  attr_accessor :id, :title, :genre, :release_date, :rating

  def initialize(title:, genre:, release_date:, rating:)
    @title = title
    @genre = genre
    @release_date = release_date
    @rating = rating
  end

  # Save game to the database
  def save
    query = <<-SQL
      INSERT INTO games (title, genre, release_date, rating)
      VALUES ('#{@title}', '#{@genre}', '#{@release_date}', #{@rating})
    SQL
    Database.client.query(query)
  end

  # List all games
  def self.all
    query = "SELECT * FROM games"
    results = Database.client.query(query)
    games = []
    results.each do |row|
      games << Game.new(
        title: row['title'],
        genre: row['genre'],
        release_date: row['release_date'],
        rating: row['rating']
      )
    end
    games
  end

  # Find a game by ID
  def self.find(id)
    query = "SELECT * FROM games WHERE id = #{id}"
    result = Database.client.query(query).first
    return nil unless result

    Game.new(
      title: result['title'],
      genre: result['genre'],
      release_date: result['release_date'],
      rating: result['rating']
    )
  end

  # Update a game's details
  def update(title:, genre:, release_date:, rating:)
    query = <<-SQL
      UPDATE games
      SET title = '#{title}', genre = '#{genre}', release_date = '#{release_date}', rating = #{rating}
      WHERE id = #{@id}
    SQL
    Database.client.query(query)
  end

  # Delete a game by ID
  def destroy
    query = "DELETE FROM games WHERE id = #{@id}"
    Database.client.query(query)
  end
end
