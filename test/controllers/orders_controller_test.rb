require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get new" do
    post items_url, params: {product_id: products(:product).id}

    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { address: @order.address,
      email: @order.email, name: @order.name, 
      foundation: @order.foundation } }
    end

    assert_redirected_to store_index_url
  end

  test "requires item in cart" do
    get new_order_url
    assert_redirected_to store_index_path
    assert_equal flash[:notice], 'Twój koszyk jest pusty.'
  end
end
