class ProductsController < ApplicationController
  def index
    @products = Product.order_by_time
                       .page(params[:page]).per Settings.products.index.per_page
  end
end
