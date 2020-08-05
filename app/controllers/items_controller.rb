class ItemsController < ApplicationController
  before_action :move_to_index, except: :index

  # before_action :set_item, only: [:show,:buy]
  # before_action :take_card, only:[:buy]
  # before_action :set_api_key
  require 'payjp'



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
    @item = Item.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      
    else
      Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end

    @address = User.where(id: current_user.id).first
    
    # card = Card.find_by(user_id: current_user.id)
    # Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
    # customer = Payjp::Customer.retrieve(card.customer_id)
    # @default_card_information = customer.cards.retrieve(card.card_id)
 
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
    
        redirect_to root_path, notice: '購入が完了しました'
   
      # redirect_to root_path
    else
      render :confirmation
    end
  end

  # def card #Cardのデータpayjpに送り情報を取り出す
  #   card = Card.find_by(user_id: current_user.id)
  #   if card.blank?
  #     redirect_to new_card_path 
  #   else
  #     Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end






  private
  def item_params
    params.require(:item).permit(:n_ame, :price, :text, :brand, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_id, :seller_id, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def item_images_params
    params.permit(:image)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end  
  
  # def take_card
  #   @card = Card.find_by(user_id: current_user.id)
  # end

  # def set_item
  #   @item = Item.find(params[:id])
  #   # @address = Address.find_by(user_id:current_user.id)
  # end

  # def set_api_key
  #   Payjp.api_key = Rails.application.credentials[:payjp][:sk_test_d67de103723148f5ae6a7676]
  # end

  # def set_customer
  #   @customer = Payjp::Customer.retrieve(@card.customer_id)
  # end

  # def set_card_information
  #   @card_information = @customer.cards.retrieve(@card.card_id)
  # end



end













# before_action :set_item, only: [:show,:pay]
# before_action :take_card, only:[:show,:pay]
# before_action :set_api_key
# def pay
#   @item.update(buyer_id: current_user.id)
#   # 現在のユーザーを購入者に登録
#   Payjp::Charge.create(
#   :amount => @item.price, 
#   :customer => @card.customer_id, 
#   :currency => 'jpy', #日本円
#  )
#   redirect_to root_path(@item.id)

# end







  # def set_item
  #   @item = Item.find(params[:id])
  #   @address = Address.find_by(user_id:current_user.id)
  # end

  # def set_api_key
  #   Payjp.api_key = Rails.application.credentials[:payjp][:sk_test_d67de103723148f5ae6a7676]
  # end

  # def take_card
  #   @card = Card.find_by(user_id: current_user.id)
  # end