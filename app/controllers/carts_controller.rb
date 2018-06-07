class CartsController < ApplicationController
	before_action :set_cart, only: [:show, :edit, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
	
	def show
		@cart = Cart.find(params[:id])
	end

	def destroy
      @cart.destroy if @cart.id == session[:cart_id]
      session[:cart_id] == nil
	  redirect_to store_index_url
	end

	private

	def invalid_cart
		logger.error "Wybrany koszyk nie istnieje"
		redirect_to store_index_url, notice: 'Niewłaściwy koszyk'
	end

	def set_cart
      @cart = Cart.find(params[:id])
    end
end
