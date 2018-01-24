class AuditoriaController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @auditoria = Auditorium.all
    respond_to do |format|
      format.json { render json: { auditoria: @auditoria }, status: :ok }
    end
  end

  def show
    @auditorium = Auditorium.find(params[:id])
    respond_to do |format|
      format.json { render json: { auditorium: @auditorium }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    @auditorium = Auditorium.new(auditorium_params)
    if @auditorium.save
      respond_to do |format|
        format.json { render json: { auditorium: @auditorium }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @auditorium.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @auditorium = Auditorium.find(params[:id])
    if @auditorium.update(auditorium_params)
      respond_to do |format|
        format.json { render json: { auditorium: @auditorium }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @auditorium.errors }, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def destroy
    @auditorium = Auditorium.find(params[:id])
    @auditorium.destroy
    respond_to do |format|
      format.json { render json: { message: 'Successfully deleted' }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  private

  def auditorium_params
    params.require(:auditorium).permit(:screen_size, :no_of_seats, :theatre_id, :movie_id)
  end
end
