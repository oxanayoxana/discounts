require_relative 'retrieve_item.rb'

class Basket
  attr_reader :my_item, :item, :basket, :basket_prices

  def initialize
    @item = RetrieveItem.new
    @my_item = my_item
    @basket = []
    @basket_prices = basket_prices
  end

  def scan(product_code)
    @my_item = item.get_item(product_code)
    add_to_basket
  end

  def add_to_basket
    basket << my_item
    set_basket_prices
  end

  def set_basket_prices
    prices =
    basket.map do |item|
      item.map {|el| el["price"]}
    end
    @basket_prices = prices.flatten.reduce(:+).round(1)
  end

  def calculate_lavender_hearts
    amount = []
    basket.each do |item|
      item.each do |el|
        if el["name"] == "Lavender heart"
          amount << el
        end
      end
    end
    amount.size
  end

  def update_lavender_hearts
    lavender_hearts =
    basket.each do |item|
      item.each do |el| 
        if el["name"] == "Lavender heart"
          el["price"] = 8.50
        end
      end
    end
    lavender_hearts
  end
end

# b = Basket.new
# b.scan(1)
# b.scan(2)
# b.scan(3)
# b.set_basket_prices
