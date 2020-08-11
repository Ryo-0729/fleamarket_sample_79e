class ItemsController < ApplicationController

  before_action :move_to_index, except: [:index, :show, :category_lists, :category_item_lists]
  before_action :set_item, only: [:edit, :update, :show, :destroy, :confirmation, :buy]
  before_action :set_category_links, only: :category_item_lists
  before_action :set_card, only: [:confirmation, :buy]
  before_action :set_category, only: [:new, :create]

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
    @otheritems = Item.all.limit(12).order(id: :desc)
    @item = Item.find(params[:id])
    @it = Item.joins(:user).find(params[:id])
    @category = Item.joins(:category).find(params[:id])
    @item_category_id = @item[:category_id]
    @item_category = Category.find(@item_category_id)
    unless @item_category[:ancestry] == nil
      @item_children_category = Category.find(@item_category.parent_id)
      @item_parent_category = Category.find(@item_category.root_id)
    end
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

  def edit
    @category_parent_array = Category.where(ancestry: nil)
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
    @address = User.where(id: current_user.id).first
    if @card.present?
      # Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)

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
    if @item.update(buyer_id: params[:buyer_id])
        # redirect_to root_path
      Payjp::Charge.create(
      :amount => @item.price, 
      :customer => @card.customer_id, 
      :currency => 'jpy', #日本円
      )

      redirect_to confirmation_item_path, notice: '購入が完了されました'

    else
      render :confirmation
    end

    # @address = User.where(id: current_user.id).first

  end

  def category_item_lists
    @items = @category.set_items
    @items = @items.where(buyer_id: nil).order(created_at: :desc)
  end

  def search
    @items = Item.search(params[:keyword])
  end

  # privateの中に入れないでください
  def get_category_children
    @category_children = Category.find(params[:parent_name]).children
    # 下のコードのコメントアウトを外して上のコードをコメントアウトすれば編集ページで最初から全てのカテゴリーを表示できます。でも出品できなくなる問題が発生します。
    # @category_children = Category.find(params[:category_id]).children
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


  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

end

