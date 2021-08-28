class Site::SearchController < SiteController
  def ads
    @categories = Category.order(:description)
    @ads = Ad.search(params[:q], params[:page])
  end
end
