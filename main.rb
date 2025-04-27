require_relative './config/database'
require_relative './migrations/create_games_table'
require_relative './app/controllers/games_controller'

db = Database.client
puts "Connected to Database"

if (db == false)
    puts "Can't Connect!"
    exit
end

# Run migrations
CreateGamesTable.up

def display_menu
    puts "\n--------------------------"
    puts "Welcome to the Game Management System!"
    puts "1. List All Games"
    puts "2. Add a New Game"
    puts "3. Update a Game"
    puts "4. Delete a Game"
    puts "5. Exit"
    print "Please choose an option (1-5): "
end

# List games
def list_games
    puts "\n--- Listing All Games ---"
    GamesController.list_games
end
  
# Add game
def add_game
    print "Enter the title of the game: "
    title = gets.chomp
    print "Enter the genre of the game: "
    genre = gets.chomp
    print "Enter the release date (YYYY-MM-DD): "
    release_date = gets.chomp
    print "Enter the rating (0-10): "
    rating = gets.chomp.to_f
  
    GamesController.add_game(title, genre, release_date, rating)
end
  
# Update game
def update_game
    print "Enter the ID of the game you want to update: "
    id = gets.chomp.to_i
  
    game = Game.find(id)
    if game.nil?
        puts "Game with ID #{id} not found."
        return
    end

    puts "Current game details:"
    puts "Title: #{game.title}"
    puts "Genre: #{game.genre}"
    puts "Release Date: #{game.release_date}"
    puts "Rating: #{game.rating}"
    puts "\nEnter new details (or press Enter to keep current value):"

    print "New title (current: #{game.title}): "
    title = gets.chomp
    title = game.title if title.empty?
  
    print "New genre (current: #{game.genre}): "
    genre = gets.chomp
    genre = game.genre if genre.empty?
  
    print "New release date (current: #{game.release_date}): "
    release_date = gets.chomp
    release_date = game.release_date if release_date.empty?
  
    print "New rating (current: #{game.rating}): "
    rating_input = gets.chomp
    rating = rating_input.empty? ? game.rating : rating_input.to_f
  
    GamesController.update_game(id, title: title, genre: genre, release_date: release_date, rating: rating)
end
  
# Delete game
def delete_game
    print "Enter the ID of the game you want to delete: "
    id = gets.chomp.to_i
    GamesController.delete_game(id)
end

loop do
    display_menu
    choice = gets.chomp.to_i
  
    case choice
    when 1
        list_games
    when 2
        add_game
    when 3
        update_game
    when 4
        delete_game
    when 5
        puts "Goodbye!"
        break
    else
        puts "Invalid choice. Please select a valid option (1-5)."
    end
    
    puts "\nPress Enter to continue..."
    gets
end