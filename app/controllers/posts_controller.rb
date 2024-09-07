class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    @user = post.user
    post.destroy
    redirect_to user_path(@user)
  end


  private
  
  def correct_user
    post = Post.find(params[:id])
    if post.user != current_user
      redirect_to user_path(current_user), alert: "他のユーザーの投稿を削除することはできません。"
    end
  end

  def post_params
    params.require(:post).permit(:user_id, :content, :image)
  end

end