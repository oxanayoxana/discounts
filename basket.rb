# frozen_string_literal: true

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
    @my_item = item.scan(product_code)
    add_to_basket
  end

  def add_to_basket
    basket << my_item
    set_basket_prices
  end

  def set_basket_prices
    prices =
      basket.map do |item|
        item.map { |el| el['price'] }
      end
    @basket_prices = prices.flatten.reduce(:+).round(1)
  end

  def individual_item
    'Lavender heart'
  end

  def individual_price
    8.50
  end

  def total_individual_items
    amount = []
    basket.each do |item|
      item.each do |el|
        amount << el if el['name'] == individual_item
      end
    end
    amount.size
  end

  def update_for_individual_discount
    lavender_hearts =
      basket.each do |item|
        item.each do |el|
          el['price'] = individual_price if el['name'] == individual_item
        end
      end
    lavender_hearts
  end
end
