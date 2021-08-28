class Backoffice::DiagramsController < BackofficeController
  def index
    %x(erd --filename='public/diagram')
  end
end
