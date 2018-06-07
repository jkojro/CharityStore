require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @item = items(:one)
  # end

  test "should create item"  do
  	assert_difference('Item.count') do
  		post items_url, params: {product_id: products(:product).id}
  	end

  	follow_redirect!

  	assert_select 'h2', 'MÓJ KOSZYK'
  	assert_select 'li', '1 x Example title'
  end

end
