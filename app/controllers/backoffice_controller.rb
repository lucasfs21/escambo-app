class BackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout "backoffice"
  def index
  end

  def pundit_user
    current_admin # current_user to Pundit
  end
end
