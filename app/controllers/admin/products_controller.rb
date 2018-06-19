class Admin::ProductsController < Admin::BaseController
  before_action :load_product, except: [:index, :new, :create]

  def index
    @products = Product.search(params[:search])
                       .page(params[:page])
                       .per Settings.page.per
  end

  def show; end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build product_params
    if @product.save
      flash[:success] = t ".success"
      redirect_to admin_products_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:success] = t ".success"
      redirect_to admin_products_url
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".success"
      redirect_to admin_products_url
    else
      flash.now[:warning] = t ".warning"
    end
  end

  private
  def load_product
    @product = Product.find_by(id: params[:id]) || not_found
  end

  def product_params
    params.require(:product).permit :name, :price, :category_id, :descriptions
  end
end
