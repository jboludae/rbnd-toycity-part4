require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  # We create our finder methods here
  # @REVIEWER: is this good practice?
  create_finder_methods("brand", "name")
  def self.create(attributes = nil)
    new_object = self.new(attributes)
    CSV.open(@@data_path, "ab") do |csv|
      csv << [new_object.id, new_object.brand, new_object.name, new_object.price]
    end
    return new_object
  end

  def self.all
    all_products_list = Array.new
    products = CSV.read(@@data_path, headers: true)
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
    if n == 1
      return self.all[0]
    else
      return self.all[0..(n-1)]
    end
  end

  def self.last(n = 1)
    if n == 1
      return self.all.last
    else
      len = self.all.length
      return self.all[(len-n)..(len-1)]
    end
  end

  def self.find(id)
    # @REVIEWER: calling self.all does not sound very efficient
    # is there a better way to do this?
    items = self.all.each.select {|item| item.id == id}
    if items.length == 0
      raise ProductNotFoundError, "Product #{id} does not exist found."
    end
    return items.first
  end

  def self.destroy(id)
    # @REVIEWER: this does not seem very efficient
    # is there any better way to do this?
    to_delete_item = self.find(id)
    # @REVIEWER: as self.find is called here, it will raise a P
    # ProductNotFoundError if id does not exist
    updated_products = self.all.select {|item| item.id != id}
    CSV.open(@@data_path, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]

      updated_products.each do |row|
        csv.puts([row.id, row.brand, row.name, row.price])
      end
    end
    return to_delete_item
  end

  def self.where(opt = {})
    if opt[:brand]
      return self.all.select { |item| item.brand == opt[:brand]}
    elsif opt[:name]
      return self.all.select { |item| item.name == opt[:name]}
    end
  end

  def update(opt = {})
    # @REVIEWER: is self.class the only way to access
    # the CLASS? I tried to define a   @@this = self
    # in
    self.class.destroy(self.id)
    self.name = opt[:name] if opt[:name]
    self.brand = opt[:brand] if opt[:brand]
    self.price = opt[:price] if opt[:price]
    self.class.create( brand: self.brand, name: self.name, price: self.price)
    return self
  end

end


