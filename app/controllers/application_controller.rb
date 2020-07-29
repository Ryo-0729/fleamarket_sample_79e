class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 追加
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :password_confirmation, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthyear, :birthmonth, :birthday, :telephone, :encrypted_password, :icon, :text, :post_first_name, :post_last_name, :post_first_name_kana, :post_last_name_kana, :post_cord, :city, :address, :building, :telephone, :prefecture_id, :user])
  end
  # 追加

  before_action :basic_auth
  before_action :basic_auth, if: :production?

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
