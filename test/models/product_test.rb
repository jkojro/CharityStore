require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
	fixtures :products

  test "product attributes must not be empty"  do
  	product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any? 
    assert product.errors[:price].any?
end
  

  test "product price must be positive" do
    current_user = users(:one)
    product = current_user.products.build(title: "Testowy produkt",
						  description: "yyy",
              user_id: 1,
              id: 1)

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]
    
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]
  
    product.price = 1
    assert product.valid?
  end

  test "product is not valid without a unique title" do
  	product = Product.new( title: products(:product).title,
  				 description: "rrr",
  				 price: 1)

  	assert product.invalid?
  	assert_equal ["has already been taken"], product.errors[:title]
  end
end
