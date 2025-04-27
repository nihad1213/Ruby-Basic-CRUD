# Game Management System

A simple command-line Ruby application for managing video games. This system allows you to:

- List all games in the database
- Add new games
- Update existing games
- Delete games

## Requirements

- Ruby 3.0 or higher
- MySQL/MariaDB database
- Bundler gem

## Installation

### Step 1: Clone the repository

```bash
git clone https://github.com/nihad1213/Ruby-Basic-CRUD.git
cd Ruby-Basic-CRUD.git
```

### Step 2: Install dependencies

The project uses Bundler to manage dependencies. Install them by running:

```bash
bundle install
```

If you don't have Bundler installed, you can install it with:

```bash
gem install bundler
```

### Step 3: Configure the database

Create a new file named `config/database.rb` with the following content:

```ruby
require 'mysql2'
require 'dotenv/load'

class Database
    def self.client()
        @client ||= Mysql2::Client.new(
            host: ENV['DB_HOST'],
            username: ENV['DB_USERNAME'],
            password: ENV['PASSWORD'],
            database: ENV['DB_NAME'],
            port: ENV['DB_PORT'] || 3306
        )
    end
end
```

Replace `your_username` and `your_password` with your MySQL/MariaDB credentials. 
Create the `games_db` database if it doesn't exist:

```sql
CREATE DATABASE games_db;
```

### Step 4: Running the application

Run the application using:

```bash
ruby main.rb
```

The application will automatically create the necessary tables on first run.

## Project Structure

```
.
├── app
│   ├── controllers
│   │   └── games_controller.rb
│   └── models
│       └── game.rb
├── config
│   └── database.rb
├── migrations
│   └── create_games_table.rb
├── Gemfile
├── Gemfile.lock
├── main.rb
└── README.md
```

## Gemfile

The project uses the following gems:

```ruby
# Gemfile

source 'https://rubygems.org'

gem 'mysql2'
gem 'dotenv'

```

After modifying the Gemfile, run `bundle install` to update dependencies.

## Database Migration

The application includes a migration to create the games table:

```ruby
# migrations/create_games_table.rb
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
```

## Testing the Application

After setting up, you can test the application with these steps:

1. Run the application: `ruby main.rb`
2. Add a new game by selecting option 2
3. List all games by selecting option 1
4. Try updating a game with option 3
5. Try deleting a game with option 4

## Troubleshooting

### Common Issues:

1. **Database connection errors**: 
   - Make sure your MySQL/MariaDB server is running
   - Check that the username and password in `database.rb` are correct
   - Verify that the `games_db` database exists

2. **Gem installation issues**:
   - Make sure you have development headers installed: 
     - For Ubuntu/Debian: `sudo apt-get install libmysqlclient-dev`
     - For CentOS/RHEL: `sudo yum install mysql-devel`
     - For macOS (with Homebrew): `brew install mysql`

3. **MySQL2 gem compatibility**:
   - If you encounter issues installing the mysql2 gem, try specifying a platform:
     `bundle install --platform=ruby`