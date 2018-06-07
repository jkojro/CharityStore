require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should create item"  do
  	assert_difference('Item.count') do
  		post items_url, params: {product_id: products(:product).id}
  	end

  	follow_redirect!

    puts @response.body

  	assert_select 'h2', 'MÓJ KOSZYK'
  	assert_select 'td', 'Example title'
  end

  test "should update item" do
    patch item_url(@item),
      params: { item: { product_id: @item.product_id } }
    assert_redirected_to item_url(@item)
  end

end
