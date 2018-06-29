class ProductsController < ApplicationController
  before_action :logged_in_user

  def index
    min_price = params[:min_price].to_i
    max_price = params[:max_price].to_i
    if min_price > max_price
      flash[:danger] = t ".eror"
      redirect_to products_path
    end
    @products = Product.search(params[:find])
      .filter_by_price(params[:min_price], params[:max_price])
      .filter_by_color(params[:color])
      .filter_by_size(params[:size])
      .page(params[:page])
      .per Settings.page.product
  end

  def show
    @product = Product.find_by id: params[:id] || not_found
  end

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".please_login"
    redirect_to login_path
  end
end
