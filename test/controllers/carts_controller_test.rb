require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
	
  test "should destroy cart" do
    post items_url, params: { product_id: products(:product).id }
    @cart = Cart.find(session[:cart_id])

    assert_difference('Cart.count', -1) do
      delete cart_url(@cart)
    end

    assert_redirected_to store_index_url
  end
end
