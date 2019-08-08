require_relative 'basket.rb'
require_relative 'promotional_rules.rb'
require_relative 'retrieve_item.rb'

class Checkout

  attr_reader :promotional_rules, :item, :basket_prices

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @item = RetrieveItem.new
    @basket_prices = basket_prices
  end

  def scan(product_code)
    promotional_rules.scan(product_code)
  end

  def total
    price = promotional_rules.max_discount
    puts "total: #{price}"
  end
end

promotional_rules = PromotionalRules.new
co = Checkout.new(promotional_rules)
co.scan(1)
co.scan(2)
co.scan(1)
co.scan(3)
co.total
