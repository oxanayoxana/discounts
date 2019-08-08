require 'yaml'

class RetrieveProducts
  attr_reader :products, :product

  def initialize products_yml_path
    @products = load_products(products_yml_path)
    @product = product
  end

  def load_products(products_yml_path)
    products = YAML.load(File.read(products_yml_path))
    products['products']
  end

  def select_product(product_code)
    product = products.select {|product| product['product_code'] == product_code}
  end
end