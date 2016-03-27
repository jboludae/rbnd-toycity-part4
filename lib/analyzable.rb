module Analyzable
  def average_price(arr)
    prices = arr.map {|product| product.price}
    price = prices.inject(0) {|sum, val| sum.to_f + val.to_f} / arr.length
    return price.round(2)
  end
end
