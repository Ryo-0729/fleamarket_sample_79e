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

  def item_params
    params.require(:item).permit(:name, :text, :prefecture_id, item_images_attributes: [:image])
  end

end
