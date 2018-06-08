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

  	assert_select 'h2', 'MÓJ KOSZYK'
  	assert_select 'td', 'Example title'
  end

  test "should create item via Ajax" do
    assert_difference('Item.count') do
      post items_url, params: { product_id: products(:product).id }, 
        xhr: true
    end

    assert_response :success 
    assert_select_jquery :html, '#cart' do
      assert_select 'tr.current_item td', /Example title/ 
    end
  end

  test "should update item" do
    patch item_url(@item),
      params: { item: { product_id: @item.product_id } }
    assert_redirected_to item_url(@item)
  end

  test "shouldn't destroy item when quantity is greater than 1" do
    assert_difference('Item.count', 0) do
      delete item_url(@item)
    end
  end

  test "should destroy item when quantity is equal to 1" do
    @item = items(:two)
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end
  end
end
