class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :update, :edit, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :invalid_product

	def index
		@products = Product.order("created_at DESC")
	end

	def show
	end

	def new
		@product = current_user.products.build
	end

	def create
		@product = current_user.products.build(product_params)

		if @product.save
			redirect_to @product, notice: "Produkt został wystawiony na sprzedaż."
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @product.update(product_params)
			redirect_to @product, notice: "Produkt został zaktualizowany."

			@products = Product.all
			ActionCable.server.broadcast 'products',
			  html: render_to_string('store/index', layout: false)
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
	
	def invalid_product
      logger.error "Produkt nie istnieje"
      redirect_to store_index_url, notice: 'Wybrano niewłaściwy produkt'
    end


end
