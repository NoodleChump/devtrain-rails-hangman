class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :check_logged_in, except: [:new, :create]
  before_action :check_correct_user,   only: [:edit, :update]
  before_action :check_admin_user,     only: [:destroy]

  helper_method :sort_column

  def index
    @users = GetSortedUsers.new(sort_column, sort_direction).call.paginate(page: params[:page], per_page: 10)
  end

  def show
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
    if current_user?(@user)
      flash[:danger] = "Users can't delete themselves"
      redirect_to users_url
    else
      @user.destroy
      flash[:success] = "User deleted successfully"
      redirect_to users_url
    end
  end

  private

  def sort_column
    params[:sort] ? params[:sort] : "name"
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) || current_user.admin?
  end
end
