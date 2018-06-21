class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase || not_found
    if user && user.authenticate(params[:session][:password])
      vertify_user user
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def vertify_user user
    if user.verified?
      log_in user
      user.admin? ? redirect_to(admin_url) : redirect_to(user)
    else
      flash[:warning] =  t ".message"
      redirect_to root_url
    end
  end
end
