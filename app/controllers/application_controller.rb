class ApplicationController < ActionController::Base
  # deviseにまつわる画面に行った時に実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # customer sign_upのテーブル追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :post_code, :address])
  end
end
