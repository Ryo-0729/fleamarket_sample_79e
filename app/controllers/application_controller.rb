class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :basic_auth, if: :production?

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, 
      keys: [:name, :lastname, :firstname, :lastname_kana, :firstname_kana, :birth_year, :birth_manth, :birth_day, :tel_num,
        :send_lastname, :send_firstname, :send_lastname_kana, :send_firstname_kana, :post_num, :prefectures, :city, :address, :address_2nd,]) # 新規登録時(sign_up時)パラメーターを追加で許可する
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end
  
end
