require_relative 'retrieve_item.rb'
require_relative 'basket.rb'
require_relative 'retrieve_products.rb'

class PromotionalRules
  MAX_PRICE = 60

  attr_accessor :basket

  def initialize
    @basket = Basket.new
  end

  def scan(product_code)
    basket.scan(product_code)
  end

  def max_discount
    over_max_price? && lavender_hearts? ? total_with_two_discounts : check_10_discount
  end

  def check_lavender_discount
    calculate_lavender_hearts >= 2 ? discount_lavender : total_no_discount
  end

  def basket_prices
    basket.set_basket_prices
  end

  def discount_10_percent
    basket_prices - discount
  end

  def discount
    discount = (basket_prices*10)/100
  end

  def check_10_discount
    basket_prices > MAX_PRICE ? discount_10_percent : check_lavender_discount
  end

  def calculate_lavender_hearts
    basket.calculate_lavender_hearts
  end

  # def lavender_hearts?
  #   return if calculate_lavender_hearts >= 2
  # end

  def update_lavender_hearts
    basket.update_lavender_hearts
    basket_prices
  end

  def discount_lavender
    update_lavender_hearts
  end

  def total_with_two_discounts
    discount_lavender
    discount_10_percent
  end

  def total_no_discount
    puts "total_no_discount: #{basket_prices}"
  end

  def over_max_price?
    return if basket_prices > MAX_PRICE 
  end
end

