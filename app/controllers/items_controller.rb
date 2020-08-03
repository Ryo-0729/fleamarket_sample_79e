class ItemsController < ApplicationController
  before_action :set_category, only: :index3
  
  def index
  end

  def show
    @items = @category.set_items
    @items = @items.where(buyer_id: nil).order("created_at DESC")
  end

  def new
  end

  def index2
    @parents = Category.where(ancestry: nil)
  end

  def index3
    @items = Item.all
    @item_images = ItemImage.all
  end

  private
  def set_category
    @category = Category.find(params[:id])
    if @category.has_children?
      @category_links = @category.children
    else
      @category_links = @category.siblings
    end
  end

end
