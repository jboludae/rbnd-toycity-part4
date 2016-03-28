require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  brands = Array.new(5).map{Faker::Company.name}
  product_names = Array.new(25).map{Faker::Commerce.product_name}
  prices = Array.new(25).map{Faker::Commerce.price}
  10.times do
    Product.create( brand: brands.sample,
    name: product_names.sample,
    price: prices.sample )
  end
end
