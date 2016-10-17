require "json"

module Products
  class StoreProduct
    attr_reader :id, :name, :price, :product_code

    def self.data
      JSON.parse(File.read(File.expand_path('../products/store_products.json', File.dirname(__FILE__))))["store_products"]
    end
    private_class_method :data

    def self.all
      data.map { |product| new(product) }
    end

    def self.find(id)
      all.detect { |product| product.id == id }
    end





    def initialize(raw_product)
      @name = raw_product["name"]
      @id = raw_product["id"].to_i
      @price = raw_product["price"].to_f
      @product_code = raw_product["product_code"]
    end
  end
end