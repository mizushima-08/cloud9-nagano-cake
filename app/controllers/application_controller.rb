class ApplicationController < ActionController::Base
  # deviseにまつわる画面に行った時に実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログアウト後に遷移するpathを設定
  def after_sign_out_path_for(resource)
    if resource == :customer
      root_path
    elsif resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  protected
  # customer sign_upのテーブル追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :postal_code, :address])
  end
end
