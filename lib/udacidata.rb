require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  def self.create(attributes = nil)
    new_object = self.new(attributes)
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(@data_path, "ab") do |csv|
      csv << [new_object.id, new_object.brand, new_object.name, new_object.price]
    end
    return new_object
  end

  def self.all
    all_products_list = Array.new
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    products = CSV.read(@data_path, headers: true)
    products.each do |row|
    #   # @REVIEWER: is there any way I can avoid this magic numbers (0, 1, 2, 3)?
    #   # @REVIEWER: creating all objects from scratch every time you
    #   # run the method does not seem very efficient. On the other hand
    #   # I could cache the products in a class variable. But then every
    #   # time I delete a product, I have to change both the database and
    #   # the cached values. What would be the best solution?
      all_products_list << self.new(id: row[0], brand: row[1],name: row[2],price: row[3])
    end
    return all_products_list
  end

  def self.first(n = 1)
    if n = 1
      return self.all[0]
    else
      return self.all
    end
  end

end


