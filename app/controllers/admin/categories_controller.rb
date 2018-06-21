class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: [:index, :new, :create]
  def index
    @categories = Category.search(params[:search])
                          .page(params[:page])
                          .per Settings.page.per
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".success"
      redirect_to categories_url
    else
      flash[:warning] = t ".warning"
      redirect_to new_category_path
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".success"
      redirect_to categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
      redirect_to categories_url
    else
      flash.now[:warning] = t ".warning"
    end
  end

  private
  def load_category
    @category = Category.find_by id: params[:id] || not_found
  end

  def category_params
    params.require(:category).permit :name
  end
end
