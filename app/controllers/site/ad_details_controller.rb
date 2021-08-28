class Site::AdDetailsController < SiteController

  def show
    @ad = Ad.find(params[:id])
    @categories = Category.order(:description)
  end
end
