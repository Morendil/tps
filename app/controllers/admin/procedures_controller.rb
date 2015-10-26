class Admin::ProceduresController < ApplicationController
  before_action :authenticate_administrateur!

  def index
    @procedures = Procedure.all
  end

  def show
    @procedure = Procedure.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = 'Procédure inéxistante'
    redirect_to admin_procedures_path
  end

  def new
    @procedure ||= Procedure.new
  end

  def create
    @procedure = Procedure.new

    @procedure.libelle = params[:procedure][:libelle]
    @procedure.description = params[:procedure][:description]
    @procedure.organisation = params[:procedure][:organisation]
    @procedure.direction = params[:procedure][:direction]
    @procedure.lien_demarche = params[:procedure][:lien_demarche]
    @procedure.use_api_carto = params[:procedure][:use_api_carto]

    unless @procedure.save
      flash.now.alert = @procedure.errors.full_messages.join('<br />').html_safe
      return render 'new'
    end

    flash.notice = 'Procédure enregistrée'

    redirect_to admin_procedures_path
  end

  def update
    @procedure = Procedure.find(params[:id])

    unless @procedure.update_attributes(create_params)
      flash.now.alert = @procedure.errors.full_messages.join('<br />').html_safe
      return render 'show'
    end

    flash.notice = 'Préocédure modifiée'
    redirect_to admin_procedures_path

  rescue ActiveRecord::RecordNotFound
    flash.alert = 'Procédure inéxistante'
    redirect_to admin_procedures_path
  end

  private

  def create_params
    params.require(:procedure).permit(:libelle, :description, :organisation, :direction, :lien_demarche, :use_api_carto)
  end
end