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













#   def pay #クレジットカード登録
#     Payjp.api_key = "sk_test_d67de103723148f5ae6a7676"
#     # ここでテスト鍵をセットしてあげる(環境変数にしても良い)
#     if params['payjpToken'].blank?
#     # paramsの中にjsで作った'payjpTokenが存在するか確かめる
#       redirect_to action: "new"
#     else
#       customer = Payjp::Customer.create(
#       card: params['payjpToken'],
#       metadata: {user_id: current_user.id}
#       )
#      # ↑ここでjay.jpに保存
#       @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
#      # ここでdbに保存
#       if @card.save
#         redirect_to action: "show"
#         flash[:notice] = 'クレジットカードの登録が完了しました'
#       else
#         redirect_to action: "pay"
#         flash[:alert] = 'クレジットカード登録に失敗しました'
#       end
#     end
#   end
# end


  # def edit
  # end




#   def new
#     # card = Card.where(user_id: current_user.id)
#     # redirect_to action: "show" if card.exists? #自動ページ切り替え

#   end

#   def create
#     # Payjp.api_key('sk_test_d67de103723148f5ae6a7676');
#     Payjp.api_key = ENV['sk_test_d67de103723148f5ae6a7676']
#     if params['payjp-token'].blank?
#       # 送られてきたデータが空ならrender :new newアクションに飛ばす
#       render :new
#       # redirect_to action: "new"
#     else
#       customer = Payjp::Customer.create(
#         description: '登録テスト',
#         card: params['payjp-token'],
#         email: current_user.email,
#         metadata: {user_id: current_user.id}
#       )
#       # cardモデルのインスタンスを作っていれる
#       @credit = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
#       if @credit.save
#         # redirect_to action: "show"
#         redirect_to new_card_path(current_user.id)
#       else
#         render :new
#       end
#     end
#   end
# end

















#   def pay #payjpとCardのデータベース作成を実施します。
#     Payjp.api_key = ENV['sk_test_d67de103723148f5ae6a7676']
#     if params['payjp-token'].blank?
#       redirect_to action: "new"
#     else
#       customer = Payjp::Customer.create(
#       description: '登録テスト', #なくてもOK
#       email: current_user.email, #なくてもOK
#       card: params['payjp-token'],
#       metadata: {user_id: current_user.id}
#       ) #念の為metadataにuser_idを入れましたがなくてもOK
#       @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
#       if @card.save
#         redirect_to action: "show"
#       else
#         redirect_to action: "pay"
#       end
#     end
#   end

#   def delete #PayjpとCardデータベースを削除します
#     card = Card.where(user_id: current_user.id).first
#     if card.blank?
#     else
#       Payjp.api_key = ENV['sk_test_d67de103723148f5ae6a7676']
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       customer.delete
#       card.delete
#     end
#       redirect_to action: "new"
#   end

  # def show #Cardのデータpayjpに送り情報を取り出します
  #   card = Card.where(user_id: current_user.id).first
  #   if card.blank?
  #     redirect_to action: "new" 
  #   else
  #     Payjp.api_key = ENV['sk_test_d67de103723148f5ae6a7676']
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end
# end