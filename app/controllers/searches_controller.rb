class SearchesController < ApplicationController
  before_action :authenticate_user_or_admin!

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word]).order(name: :asc).page(params[:page])
    else
      @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc).page(params[:page]) 
    end
  end
end
