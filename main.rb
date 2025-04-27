require_relative './config/database'
require_relative './migrations/create_games_table'

db = Database.client
puts "Connected to Database"

if (db == false)
    puts "Can't Connected!"
end

# Run migrations
CreateGamesTable.up

