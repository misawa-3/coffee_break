
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_status

  protected

  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  def after_sign_out_path_for(resource_or_scope)
    '/'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  private

  def check_user_status
    if user_signed_in? && current_user.deactivated?
      sign_out(current_user) # 非有効化されたユーザーをログアウト
      redirect_to root_path, alert: "このアカウントは非有効化されています。"
    end
  end
end