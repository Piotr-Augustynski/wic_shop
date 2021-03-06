class Admin::CategoriesController < Admin::BaseController
  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result(distinct: true)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'Pomyślnie dodano kategorię'
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path, notice: 'Pomyślnie edytowano kategorię'
    else
      render action: :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
