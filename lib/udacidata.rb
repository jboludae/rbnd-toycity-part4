require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  def self.create(attributes = nil)
    new_object = self.new(attributes)
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(@data_path, "a") do |csv|
      csv << [new_object.id, new_object.brand, new_object.name, new_object.price]
    end
  end
end


