class Post < ApplicationRecord
  has_one_attached :image  
  belongs_to :user
  
  def new
    @post = Post.new
  end
  
  # 投稿データの保存
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path
  end
  def index
  end

  def show
  end
  
  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
  
end
