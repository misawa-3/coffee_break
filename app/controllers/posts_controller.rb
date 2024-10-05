class PostsController < ApplicationController
  def new
    @post = Post.new
    @post_comment = PostComment.new
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

    if params[:query].present? && params[:match_type].present?
      match_type = params[:match_type]
      query = params[:query]
  
      if params[:user_id].present?
        @posts = @posts.where(user_id: params[:user_id])
      end
  
      if match_type == 'partial'
        @posts = @posts.where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
      elsif match_type == 'exact'
        @posts = @posts.where('title = ? OR content = ?', query, query)
      end
    end
  
    @posts = @posts.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
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