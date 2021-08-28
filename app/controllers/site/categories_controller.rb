class Site::CategoriesController < SiteController
  def show
    @categories = Category.order(:description)
    @category = Category.friendly.find(params[:id])
    @ads = Ad.by_category(@category.id, params[:page])
  end
end
