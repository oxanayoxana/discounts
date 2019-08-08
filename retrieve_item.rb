require_relative 'retrieve_products.rb'

class RetrieveItem

  attr_accessor :products, :item, :name, :product_code, :price, :product

  def initialize
    @products = RetrieveProducts.new('products.yml')
    @product = product
    @item = item
    @name = name
    @price = price
    # @product_code = product_code
  end
  
  def get_item(product_code)
    @item = products.select_product(product_code)
  end

  def get_item_name
    name = item[0]['name']
  end

  def get_item_price
    price = item[0]['price']
  end

  def update_price
    get_item_price = 8.50
  end
end
