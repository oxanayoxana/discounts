require_relative 'retrieve_item.rb'
require_relative 'retrieve_products.rb'

class PromotionalRules
  MAX_PRICE = 60

  attr_accessor :item, :basket, :my_item, :basket_prices

  def initialize
    @item = RetrieveItem.new
    @my_item = my_item
    @basket = []
    @basket_prices = basket_prices
  end

  def select_item(product_code)
    @my_item = item.get_item(product_code)
  end

  def add_to_basket
    basket << my_item
  end

  def set_basket_prices
    prices =
    basket.map do |item|
      item.map {|el| el["price"]}
    end
    @basket_prices = prices.flatten.reduce(:+).round(1)
    # puts "inital basket prices: #{basket_prices}" 
  end

  def discount_10_percent
    @basket_prices = basket_prices - discount
  end

  def discount
    discount = (basket_prices*10)/100
  end

  def max_discount
    over_max_price? && lavender_hearts? ? total_with_two_discounts : check_10_discount
  end

  def check_10_discount
    basket_prices > MAX_PRICE ? discount_10_percent : check_lavender_discount
  end

  def check_lavender_discount
    lavender_hearts? == true ? discount_lavender : total_no_discount
    puts "lavender hearts : #{lavender_hearts?}"
  end

  def over_max_price?
    return if basket_prices > MAX_PRICE 
  end

  def calculate_lavender_hearts
    amount = []
    basket.each do |item_array|
      item_array.each do |el|
        if el["name"] == "Lavender heart"
          amount << el
        end
      end
    end
    amount.size
  end

  def lavender_hearts?
    return if calculate_lavender_hearts >= 2
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
  end

  def discount_lavender
    puts "lavender basket prices: #{basket_prices}"
    set_basket_prices
    update_lavender_hearts
  end

  def total_with_two_discounts
    discount_lavender
    discount_10_percent
  end

  def total_no_discount
    basket_prices
  end

  def show_price
    puts "final basket prices: #{basket_prices}"
  end
end

p = PromotionalRules.new
# p.select_item(2)
# p.add_to_basket
p.select_item(1)
p.add_to_basket
p.select_item(3)
p.add_to_basket
p.select_item(1)
p.add_to_basket
p.set_basket_prices
p.max_discount
p.show_price
# puts p.set_basket_prices
# puts p.total_with_two_discounts
# puts p.discount_10_percent
# puts p.discount_lavender
# p.discount
# p.set_basket_prices



# Test data
# ---------
# Basket: 001,002,003
# Total price expected: £66.78

# Basket: 001,003,001
# Total price expected: £36.95

# Basket: 001,002,001,003
# Total price expected: £73.76


# [[{"product_code"=>1, "name"=>"Lavender heart", "price"=>9.25}],
# [{"product_code"=>3, "name"=>"Kids T-shirt", "price"=>19.95}],
# [{"product_code"=>2, "name"=>"Personalised cufflinks", "price"=>45.0}]]
