require_relative '../models/game'

class GamesController
  # Add a new game
  def self.add_game(title, genre, release_date, rating)
    game = Game.new(title: title, genre: genre, release_date: release_date, rating: rating)
    
    if game.save
      puts "Game '#{title}' added successfully!"
      return true
    else
      puts "Failed to add game '#{title}'."
      return false
    end
  end

  # List all games
  def self.list_games
    games = Game.all
    if games.empty?
      puts "No games found."
    else
      games.each do |game|
        puts "ID: #{game.id}, Title: #{game.title}, Genre: #{game.genre}, Release Date: #{game.release_date}, Rating: #{game.rating}"
      end
    end
  end

  # Update a game by ID
  def self.update_game(id, title:, genre:, release_date:, rating:)
    if Game.update(id: id, title: title, genre: genre, release_date: release_date, rating: rating)
      puts "Game updated successfully!"
      return true
    else
      puts "Game with ID #{id} not found or update failed."
      return false
    end
  end

  # Delete a game by ID
  def self.delete_game(id)
    game = Game.find(id)
    if game
      if game.destroy
        puts "Game '#{game.title}' deleted successfully!"
        return true
      else
        puts "Failed to delete game."
        return false
      end
    else
      puts "Game with ID #{id} not found."
      return false
    end
  end
end