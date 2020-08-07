class CardsController < ApplicationController

  require "payjp"
  before_action :set_card, only: [:destroy, :show]


  def edit
  end

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if card.exists?
  end

  def pay #payjpとCardのデータベース作成
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    #保管した顧客IDでpayjpから情報取
    
    if params['payjp-token'].present?
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      
      
      if @card.save
        redirect_to card_path(current_user.id)
      
      else
        redirect_to new_cards_path
      end

    else
      redirect_to new_card_path
    end
  end

  def destroy #PayjpとCardデータベースを削除
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    else
    end
      redirect_to new_card_path
  end

  def show #Cardのデータpayjpに送り情報を取り出す
    if @card.present?
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
 
    else
      redirect_to new_card_path 

    end
  end

  private

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end
end