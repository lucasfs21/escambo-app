class Site::HomeController < SiteController
  def index
    @categories = Category.order(:description)
    @ads = Ad.ascending_order(params[:page])
    @carousel = Ad.limit(3).order("RANDOM()")
  end
end
