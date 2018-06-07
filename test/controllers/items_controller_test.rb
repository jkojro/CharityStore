require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should create item"  do
  	assert_difference('Item.count') do
  		post items_url, params: {product_id: products(:product).id}
  	end

  	follow_redirect!

  	assert_select 'h2', 'MÓJ KOSZYK'
  	assert_select 'li', 'Example title'
  end

end
