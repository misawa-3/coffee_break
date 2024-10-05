class Admin::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    admin_users_path # ログイン後の遷移先
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path # ログアウト後の遷移先
  end
end