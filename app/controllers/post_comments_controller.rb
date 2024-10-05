class PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.post_comments.new(post_comment_params)
    comment.user = current_user
    if comment.save
      redirect_to post_path(post), notice: 'コメントが投稿されました。'
    else
      redirect_to post_path(post), alert: 'コメントの投稿に失敗しました。'
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end