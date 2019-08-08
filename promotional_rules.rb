# frozen_string_literal: true

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
    two_discounts ? total_with_two_discounts : check_10_discount
  end

  def two_discounts
    over_max_price? && total_individual_items >= 2
  end

  def check_10_discount
    basket_prices > MAX_PRICE ? discount_10_percent : check_individual_discount
  end

  def check_individual_discount
    total_individual_items >= 2 ? individual_discount : total_no_discount
  end

  def basket_prices
    basket.set_basket_prices
  end

  def discount_10_percent
    basket_prices - discount
  end

  def discount
    (basket_prices * 10) / 100
  end

  def over_max_price?
    basket_prices > MAX_PRICE
  end

  def total_individual_items
    basket.total_individual_items
  end

  def update_for_individual_discount
    basket.update_for_individual_discount
  end

  def individual_discount
    update_for_individual_discount
    basket_prices
  end

  def total_with_two_discounts
    individual_discount
    discount_10_percent
  end

  def total_no_discount
    puts "total_no_discount: #{basket_prices}"
  end
end
