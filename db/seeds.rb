# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(name: "Mahfuz Alam,", email: "mahfuz.alam@gmail.com", password: "123456", password_confirmation: "123456" ,role: "admin")
User.create!(name: "Gourav Pareek", email: "gaurav.pareek@gmail.com", password: "123456", password_confirmation: "123456",  role: "user")
User.create!(name: "Jabra Ram", email: "jabra.ram@gmail.com", password: "123456", password_confirmation: "123456",  role: "user")