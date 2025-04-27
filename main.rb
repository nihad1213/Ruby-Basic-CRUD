require_relative './config/database'

db = Database.client
puts "Connected to Database"

if (db == false)
    puts "Can't Connected!"
end