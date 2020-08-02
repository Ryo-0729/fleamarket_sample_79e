class ItemsController < ApplicationController
  
  require 'payjp'

  def confirmation
    card = Card.where(user_id: current_user.id).first
    #テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
      # Payjp.api_key = ENV["sk_test_d67de103723148f5ae6a7676"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end


  def pay
    @product = Item.find(params[:seller_id])
    # すでに購入されていないか？
    if @product.buyer.present? 
      redirect_back(fallback_location: root_path) 
    elsif @card.blank?
      # カード情報がなければ、買えないから戻す
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      # 購入者もいないし、クレジットカードもあるし、決済処理に移行
      Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
      # 請求を発行
      Payjp::Charge.create(
      :amount => 1700, #支払金額を入力（itemテーブル等に紐づけても良い）
      :customer => card.customer_id, #顧客ID
      :currency => 'jpy', #日本円
      # amount: @product.price,
      # customer: @card.customer_id,
      # currency: 'jpy',
      )
      # 売り切れなので、productの情報をアップデートして売り切れにします。
      if @product.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to controller: 'products', action: 'show', id: @product.id
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: 'products', action: 'show', id: @product.id
      end
    end
  end



  def index
  end

  def show
  end

  def new
  end

  def index2
  end
  
  def confirmation
  end
end



# def pay
#   card = Card.where(user_id: current_user.id).first
#   Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
#   Payjp::Charge.create(
#   :amount => 1700, #支払金額を入力（itemテーブル等に紐づけても良い）
#   :customer => card.customer_id, #顧客ID
#   :currency => 'jpy', #日本円
# )
# redirect_to action: 'done' #完了画面に移動