# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create categories
Category.create(name: 'Electronics')
Category.create(name: 'Clothing')

# Create products
electronics = Category.find_by(name: 'Electronics')
clothing = Category.find_by(name: 'Clothing')

Product.create(title: 'Laptop', description: 'A powerful laptop', price: 999.99, category: electronics)
Product.create(title: 'Smartphone', description: 'The latest smartphone', price: 699.99, category: electronics)

Product.create(title: 'T-shirt', description: 'A comfortable t-shirt', price: 19.99, category: clothing)
Product.create(title: 'Jeans', description: 'Stylish jeans', price: 39.99, category: clothing)
