class StaticPagesController < ApplicationController
  def home
    @hot_products = Product.all.order("updated_at desc").take(8)
    @new_products = Product.order("updated_at desc").take(8)
    @sale_products = Product.all.take(8)
  end

  def help; end

  def about; end

  def contact; end
end
