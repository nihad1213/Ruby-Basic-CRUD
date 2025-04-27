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