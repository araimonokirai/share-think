class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @post = Post.new
  end
  
  def hide
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。またのご利用をお待ちしております。"
    redirect_to root_path
  end
  
  def index
    @users = User.all
    @posts = Post.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end
end
