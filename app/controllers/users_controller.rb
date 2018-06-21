class UsersController < ApplicationController
  before_action :load_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_mail_active"
      redirect_to root_url
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
