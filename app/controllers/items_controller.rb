class ItemsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @it = Item.joins(:user).find(params[:id])
    @category = Item.joins(:category).find(params[:id])
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
      @item.item_images.new(item_images_params)
      render :new
    end
  end

  def index2
  end
  
  def confirmation
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :brand, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_id, :seller_id, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def item_images_params
    params.permit(:image)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end  

end
