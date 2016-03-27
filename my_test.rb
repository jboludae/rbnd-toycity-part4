
require_relative 'lib/product'
require_relative 'data/seeds'

@data_path = File.dirname(__FILE__) + "/data/data.csv"

CSV.open(@data_path, "wb") do |csv|
  csv << ["id", "brand", "product", "price"]
end
db_seed

Product.destroy(2)
