class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :update, :edit, :destroy]

	def index
		@products = Product.order("created_at DESC")
	end

	def show
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			redirect_to @product, notice: "Produkt został wystawiony na sprzedaż."
		else
			redner 'new'
		end
	end

	def edit

	end

	def update
		if @product.update(product_params)
			redirect_to @product, notice: "Product został zaktualizowany."
		else
			render 'edit'
		end
	end

	def destroy
		@product.destroy
		redirect_to products_path
	end

	private

	def set_product
		@product = Product.find(params[:id])
	end

	def product_params
		params.require(:product).permit(:title, :description, :price)
	end


end
