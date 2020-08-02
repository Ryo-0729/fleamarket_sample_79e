class CardsController < ApplicationController

  require "payjp"
  # before_action :card_params

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if card.exists?
  end

  def pay #payjpとCardのデータベース作成
    Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
    #保管した顧客IDでpayjpから情報取
    
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      
      
      if @card.save
        redirect_to card_path(current_user.id)
      
      else
        redirect_to new_cards_path
        # redirect_to pay_cards_path
      end
    end
  end

  def destroy #PayjpとCardデータベースを削除
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to new_card_path
  end

  def show #Cardのデータpayjpに送り情報を取り出す
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to new_card_path 
    else
      Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  private

  # def card_params
  #   params.require(:card).permit(:user_id, :customer_id, :card_id)
  # end
 
  # def set_card
  #   @card = Card.find_by(user_id: current_user.id) if Card.find_by(user_id: current_user.id).present?
  # end
  
  # def pay_params
  #   params.permit(:"payjp-token")
  # end

end