# frozen_string_literal: true

require 'yaml'

class RetrieveProducts
  attr_reader :products

  def initialize(products_yml_path)
    @products = load_products(products_yml_path)
  end

  def load_products(products_yml_path)
    products = YAML.safe_load(File.read(products_yml_path))
    products['products']
  end

  def select_product(product_code)
    products.select { |product| product['product_code'] == product_code }
  end
end
