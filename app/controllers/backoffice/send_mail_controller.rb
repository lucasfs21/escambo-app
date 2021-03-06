class Backoffice::SendMailController < ApplicationController
  def new
    @admin = Admin.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    begin
      raise 'error'
      AdminMailer.send_message(current_admin, params[:'recipient-name'],
                                params[:'subject-text'], params[:'message-text']).deliver_now
      @notify_message = "Email enviado com sucesso!"
      @notify_flag = "success"
    rescue
      @notify_message = "Erro ao enviar email. Tente novamente"
      @notify_flag = "danger"
    end

    respond_to do |format|
      format.js
    end
  end

end
