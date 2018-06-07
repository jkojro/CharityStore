class ItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_item

  def index
	@items = Item.all
  end

  def show
  end

  def new
	@item = Item.new
  end

  def edit
  end

  def create
	  product = Product.find(params[:product_id])
	  @item = @cart.add_product(product)

	  if @item.save
		  redirect_to @item.cart
	  else
		  render :new
	  end
  end

  def update
    if @item.update(item_params)
      redirect_to @item,
        notice: 'Towar został zaktualizowany.' 
    else
      render :edit 
    end
  end

  def destroy
    if @item.quantity > 1
      @item.quantity -=1
      @item.save
    else
      @item.destroy
    end
    redirect_to @cart,
      notice: 'Towar został usunięty z koszyka.'
  end

  private

  def set_item
	  @item = Item.find(params[:id])
  end

  def item_params
	  params.require(:item).permit(:product_id)
  end

  def invalid_item
      logger.error "Towar nie istnieje"
      redirect_to store_index_url, notice: 'Wybrany towar nie istnieje'
    end
end



