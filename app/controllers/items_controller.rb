class ItemsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render new_item_path
    end
  end

  def index2
  end
  
  def confirmation
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :brand_id, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_id, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
