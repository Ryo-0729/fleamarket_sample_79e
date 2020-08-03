class ItemsController < ApplicationController
  before_action :move_to_index, except: :index

  require 'payjp'

  # def confirmation
  #   card = Card.where(user_id: current_user.id).first
  #   #テーブルからpayjpの顧客IDを検索
  #   if card.blank?
  #     #登録された情報がない場合にカード登録画面に移動
  #     redirect_to controller: "card", action: "new"
  #   else
  #     Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
  #     # Payjp.api_key = ENV["sk_test_d67de103723148f5ae6a7676"]
  #     #保管した顧客IDでpayjpから情報取得
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
  #   @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end
  # def pay
  #   # 購入者もいないし、クレジットカードもあるし、決済処理に移行
  #   Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
  #   # 請求を発行
  #   Payjp::Charge.create(

  #     :amount => @item_amount.price, #支払金額を引っ張ってくる
  #     :customer => @card_customer.customer_id,  #顧客ID
  #     :currency => 'jpy',    
  #   # amount: @product.price,
  #   # customer: @card.customer_id,
  #   # currency: 'jpy',
  #   )
  #   # 売り切れなので、productの情報をアップデートして売り切れにします。
  # end

  # def pay
  #   @product = Item.find(params[:buyer_id])
  #   # すでに購入されていないか？
  #   if @product.buyer.present? 
  #     redirect_back(fallback_location: root_path) 
  #   elsif @card.blank?
  #     # カード情報がなければ、買えないから戻す
  #     redirect_to action: "new"
  #     flash[:alert] = '購入にはクレジットカード登録が必要です'
  #   else
  #     # 購入者もいないし、クレジットカードもあるし、決済処理に移行
  #     Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
  #     # 請求を発行
  #     Payjp::Charge.create(
 
  #     :amount => 1700, #支払金額を入力（itemテーブル等に紐づけても良い）
  #     :customer => card.customer_id, #顧客ID
  #     :currency => 'jpy', #日本円
  #     # amount: @product.price,
  #     # customer: @card.customer_id,
  #     # currency: 'jpy',
  #     )
  #     # 売り切れなので、productの情報をアップデートして売り切れにします。
  #     if @product.update(buyer_id: current_user.id)
  #       flash[:notice] = '購入しました。'
  #       redirect_to controller: 'products', action: 'show', id: @product.id
  #     else
  #       flash[:alert] = '購入に失敗しました。'
  #       redirect_to controller: 'products', action: 'show', id: @product.id
  #     end
  #   end
  # end


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
  end

  def buy
    if @buyer_id = Item.create(buyer_id: params[:buyer_id], id: params[:id])
      redirect_to root_path
    else
      render :confirmation
    end
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


















# class ItemsController < ApplicationController

#   before_action :move_to_index, except: :index

#   # before_action :buy_seller
#   require 'payjp'

#   # before_action :set_item, only:[:show,:pay]
#   # cardテーブルから現在のユーザーのレコード
#   # before_action :take_card, only:[:confirmation,:pay]
#   # before_action :set_api_key

#   # def confirmation
#   #   if @card.blank?
#   #     #登録された情報がない場合にカード登録画面に移動
#   #     flash[:alert] = '購入前にカード登録してください'
#   #     redirect_to new_card_path and return
#   #   else
#   #     #保管した顧客IDでpayjpから情報取得
#   #     # カードが登録されていれば
#   #     set_customer
#   #     #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
#   #     set_card_information
#   #   end
#   #   if current_user.address == nil
#   #       flash[:alert] = '購入前に住所登録してください'
#   #       redirect_to new_address_path
#   #   end
#   # end


#   # def buy
#   #   @product = Item.find(params[:buyer_id])
#   #   # すでに購入されていないか？
#   #   if @product.item.present? 
#   #     redirect_back(fallback_location: root_path) 
#   #   elsif @card.blank?
#   #     # カード情報がなければ、買えないから戻す
#   #     redirect_to action: "new"
#   #     flash[:alert] = '購入にはクレジットカード登録が必要です'
#   #   else
#   #     # 購入者もいないし、クレジットカードもあるし、決済処理に移行
#   #     Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
#   #     # 請求を発行
#   #     Payjp::Charge.create(
#   #     amount: @product.price,
#   #     customer: @card.customer_id,
#   #     currency: 'jpy',
#   #     )
#   #     # 売り切れなので、productの情報をアップデートして売り切れにします。
#   #     if @product.update(seller_id: current_user.id)
#   #       flash[:notice] = '購入しました。'
#   #       redirect_to controller: 'products', action: 'show', id: @product.id
#   #     else
#   #       flash[:alert] = '購入に失敗しました。'
#   #       redirect_to controller: 'products', action: 'show', id: @product.id
#   #     end
#   #   end
#   # end

#   def pay
#     # 現在のユーザーと購入者としてbuyer_idカラムへ
#     # @item.update(buyer_id: current_user.id)
#     Payjp::Charge.create(
#     :amount => 1700,
#     # :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
#     :customer => @card.customer_id, #顧客ID
#     :currency => 'jpy', #日本円
#     )
#     redirect_to action: 'done' #完了画面に移動

#       # # 購入者もいないし、クレジットカードもあるし、決済処理に移行
#       # Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
#       # # 請求を発行
#       # Payjp::Charge.create(
#       # :amount => 1700, #支払金額を入力（itemテーブル等に紐づけても良い）
#       # :customer => card.customer_id, #顧客ID
#       # :currency => 'jpy', #日本円
#   end

#   def index
#   end

#   def show
#   end

#   def new
#     @item = Item.new
#     @item.item_images.new
#   end

#   def create
#     @item = Item.new(item_params)
#     if @item.save
#       redirect_to root_path
#     else
#       @item.item_images.new(item_images_params)
#       render :new
#     end
#   end

#   def index2
#   end

#   private
#   def item_params
#     params.require(:item).permit(:name, :price, :text, :brand, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_id, :seller_id, item_images_attributes: [:image]).merge(user_id: current_user.id)
#   end

#   def item_images_params
#     params.permit(:image)
#   end

#   def move_to_index
#     redirect_to action: :index unless user_signed_in?
#   end  


#   # def buy_seller
#   #   params.require(:item).permit(:buyer_id)
#   # end





#   # def set_item
#   #   @item = Item.find(params[:id])
#   #   @address = Address.find_by(user_id:current_user.id)
#   # end
#   # def set_api_key
#   #   Rails.application.credentials.dig(:payjp, :sk_test_d67de103723148f5ae6a7676)
#   #   # Payjp.api_key = Rails.application.credentials[:payjp][:sk_test_d67de103723148f5ae6a7676]
#   # end
#   # # payjpから顧客データを取得
#   # def set_customer
#   #   @customer = Payjp::Customer.retrieve(@card.customer_id)
#   # end
#   # # ＠customerの顧客データ
#   # def set_card_information
#   #   @card_information = @customer.cards.retrieve(@card.card_id)
#   # end
#   # def take_card
#   #   @card = Card.find_by(user_id: current_user.id)
#   # end
# end