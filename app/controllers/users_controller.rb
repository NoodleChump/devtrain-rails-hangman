class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_rankings, only: [:index]

  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  helper_method :sort_column

  def index
    @users = UsersPresenter.apply_sort(User.all, sort_column, sort_direction).paginate(page: params[:page], per_page: 10)
  end

  def show
    @ranking = FindUserRanking.new(@user).call()
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "User created successfully"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted successfully"
    redirect_to users_url
  end

  private

  def sort_column
    params[:sort] ? params[:sort] : "name"
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_rankings
    @rankings = Hash.new
    User.all.each { |user| @rankings[user.id] = FindUserRanking.new(user).call() }
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
