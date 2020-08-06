class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :category_lists, :category_item_lists]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :set_category_links, only: :category_item_lists

  def index
    @items = Item.all.order(id: :desc)
    @ladies = Item.where(category_id: "1").order(id: :desc)
    @mens = Item.where(category_id: "199").order(id: :desc)
    @electricalappliances = Item.where(category_id: "889").order(id: :desc)
    @hobby = Item.where(category_id: "676").order(id: :desc)
  end

  def show
    @item = Item.find(params[:id])
    @it = Item.joins(:user).find(params[:id])
    @category = Item.joins(:category).find(params[:id])
  end

  def new
    @item = Item.new
    @item.item_images.new
    @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品が出品されました"
      redirect_to root_path
    else
      @item.item_images.new(item_images_params)
      @category_parent_array = Category.where(ancestry: nil)
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

  def category_lists
    @parents = Category.where(ancestry: nil)
  end
  
  def confirmation
    @item = Item.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      
    else
      Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)

      @card_brand = @default_card_information.brand
      case @card_brand
      when "Visa"
        @card_image = "card_visa_b.gif"
      when "JCB"
        @card_image = "card_jcb_b.gif"
      when "MasterCard"
        @card_image = "card_master_b.gif"
      when "American Express"
        @card_image = "card_amex_b.gif"
      when "Diners Club"
        @card_image = "card_diners_b.gif"
      when "Discover"
        @card_image = "card_dc_b.gif"
      end
    end
  end

  def buy
    @card = Card.find_by(user_id: current_user.id)
    @item = Item.find(params[:id])
    if Item.update(buyer_id: params[:buyer_id], id: params[:id])
      # redirect_to root_path
      Payjp::Charge.create(
      :amount => @item.price, 
      :customer => @card.customer_id, 
      :currency => 'jpy', #日本円
      )
    
      # flash[:notice] = "購入が完了しました"

      redirect_to confirmation_item_path, notice: '購入が完了されました'
    else
      render :confirmation
    end

    @address = User.where(id: current_user.id).first
  end

  def category_item_lists
    @items = @category.set_items
    @items = @items.where(buyer_id: nil)
  end

  def search
    @items = Item.search(params[:keyword])
  end

  # privateの中に入れないでください
  def get_category_children
    @category_children = Category.find(params[:parent_name]).children
  end

  # privateの中に入れないでください
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :brand, :category_id, :size_id, :condition_id, :postage_payer_id, :prefecture_id, :shipping_method_id, :preparation_id, :seller_id, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def item_upgrade_params
    params.require(:item).permit(:name, :price, :text, :brand, :category_id, :size_id, :condition_id, :postage_payer_id, :prefecture_id, :shipping_method_id, :preparation_id, :seller_id, item_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def item_images_params
    params.permit(:image)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_category_links
    @category = Category.find(params[:id])
    if @category.has_children?
      @category_links = @category.children
    else
      @category_links = @category.siblings
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

end