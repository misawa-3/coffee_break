class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end
  
  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  # 退会メソッド
  def deactivate
    user = User.find(params[:id])
    user.deactivate!
    redirect_to admin_users_path, notice: "ユーザーを退会状態にしました。"
  end
  # 凍結メソッド
  def freeze
    user = User.find(params[:id])
    user.freeze!
    redirect_to admin_users_path, notice: "ユーザーを凍結しました。"
  end
  # アクティブに戻すメソッド
  def reactivate
    user = User.find(params[:id])
    user.reactivate!
    redirect_to admin_users_path, notice: "ユーザーをアクティブに戻しました。"
  end
end
