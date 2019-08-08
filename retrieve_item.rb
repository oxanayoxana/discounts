# frozen_string_literal: true

require_relative 'retrieve_products.rb'

class RetrieveItem
  attr_accessor :products, :item, :product_code

  def initialize
    @products = RetrieveProducts.new('products.yml')
  end

  def scan(product_code)
    @item = products.select_product(product_code)
  end
end
