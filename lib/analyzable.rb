module Analyzable

  def average_price(arr)
    prices = arr.map {|product| product.price}
    price = prices.inject(0) {|sum, val| sum.to_f + val.to_f} / arr.length
    return price.round(2)
  end

  def count_by_brand(list)
    result = Hash.new(0)
    list.each do |item|
      result[item.brand] += 1
    end
    return result
  end

  def count_by_name(list)
    result = Hash.new(0)
    list.each do |item|
      result[item.name] += 1
    end
    return result
  end

end
