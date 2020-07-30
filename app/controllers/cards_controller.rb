class CardsController < ApplicationController

  require 'payjp'

  # def edit
  # end




  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists? #自動ページ切り替え

  end

  def create
    Payjp.api_key = ENV['sk_test_d67de103723148f5ae6a7676']
    if params['payjp-token'].blank?
      # 送られてきたデータが空ならrender :new
      render :new
      # redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: '登録テスト',
        card: params['payjp-token'],
        email: current_user.email,
        metadata: {user_id: current_user.id}
      )
      # cardモデルのインスタンスを作っていれる
      @credit = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit.save
        # redirect_to action: "show"
        redirect_to users_path(current_user.id)
      else
        render :new
      end
    end
  end
end



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

#   def show #Cardのデータpayjpに送り情報を取り出します
#     card = Card.where(user_id: current_user.id).first
#     if card.blank?
#       redirect_to action: "new" 
#     else
#       Payjp.api_key = ENV['sk_test_d67de103723148f5ae6a7676']
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       @default_card_information = customer.cards.retrieve(card.card_id)
#     end
#   end
# end