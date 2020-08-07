class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  def index
    @items = Item.all.order(id: :desc)
    ladies = Category.find(1)
    @ladies = Item.where(category_id: ladies.subtree).order(id: :desc)
    mens = Category.find(199)
    @mens = Item.where(category_id: mens.subtree).order(id: :desc)
    electricalappliances = Category.find(889)
    @electricalappliances = Item.where(category_id: electricalappliances.subtree).order(id: :desc)
    hobby = Category.find(617)
    @hobby = Item.where(category_id: hobby.subtree).order(id: :desc)
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
      flash[:notice] = "商品が出品されました"
      redirect_to root_path
    else
      @item.item_images.new(item_images_params)
      render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:notice] = "商品は削除されました"
      redirect_to root_path
    else
      redirect_to item_path
    end
  end

  def update
    if @item.update(item_upgrade_params)
      redirect_to root_path
    else
      redirect_back fallback_location: edit_item_path, flash:{alerting: @item.errors.full_messages}
    end
  end

  def index2
  end
  
  def confirmation
  end

  def search
    @items = Item.search(params[:name])
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :brand, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_id, :seller_id, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def item_upgrade_params
    params.require(:item).permit(:name, :price, :text, :brand, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_id, :seller_id, item_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def item_images_params
    params.permit(:image)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end  

  def set_item
    @item = Item.find(params[:id])
  end

end
