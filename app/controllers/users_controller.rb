class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def update_user_name
    @user = current_user
    if @user.update(user_name_params)
      redirect_to user_path(@user), notice: 'ユーザー名が更新されました'
    else
      render :edit
    end
  end

  def update_user_image
    @user = current_user
    if @user.update(user_image_params)
      redirect_to user_path(@user), notice: 'プロフィール画像が更新されました'
    else
      render :edit
    end
  end
  
  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "フォローワー"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
  
  def deactivate
    current_user.deactivate!
    redirect_to root_path, notice: 'アカウントが非有効化されました。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :header_image)
  end
  
  def user_name_params
    params.require(:user).permit(:name)
  end

  def user_image_params
    params.require(:user).permit(:profile_image)
  end
  
end
