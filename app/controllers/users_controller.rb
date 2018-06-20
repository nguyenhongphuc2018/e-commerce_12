class UsersController < ApplicationController
  before_action :load_user
  
  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "home_page.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id] || not_found
  end
end
