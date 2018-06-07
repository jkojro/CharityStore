class ItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

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
    @item.destroy
    redirect_to items_url,
      notice: 'Towar został usunięty z koszyka.'
  end

  private

  def set_item
	  @item = Item.find(params[:id])
  end

  def item_params
	  params.require(:item).permit(:product_id)
  end
end



