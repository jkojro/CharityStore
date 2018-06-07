class CartsController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
	def show
		@cart = Cart.find(params[:id])
	end

	private
	
	def invalid_cart
		logger.error "Wybrany koszyk nie istnieje"
		redirect_to store_index_url, notice: 'Niewłaściwy koszyk'
	end
end
