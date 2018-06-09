class OrdersController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:new, :create]
	before_action :ensure_cart_isnt_empty, only: :new
	before_action :set_order, only:[:show, :ipdate, :edit, :destroy]

	def new
		@order = Order.new
	end

  def create
  	@items = @cart.items
  	sellers = (@items.map {|item| item.product.user_id}).uniq
  	sellers.each do |seller|
  		@order = Order.new(order_params)
        @order.add_sellers_items_from_cart(@items, seller)
        @order.save
        if seller == sellers.last
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          redirect_to store_index_url, notice: 'Dzięki za złożenie zamówienia.'
        end
    end
  end



	private

	def set_order
	  @order = Order.find(params[:id])
	end

    def order_params
      params.require(:order).permit(:name, :address, :email, :foundation)
    end

	def ensure_cart_isnt_empty
      if @cart.items.empty?
        redirect_to store_index_url, notice: 'Twój koszyk jest pusty.'
      end
    end
end
