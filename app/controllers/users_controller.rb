class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :edit, :update]
  before_action :authenticate_user, only: [:edit, :update ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "User was successfully updated." 
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end

    def authenticate_user
    unless @user == current_user
      redirect_to pictures_path
    end
  end


end
