class ShowtimesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @showtimes = Showtime.all
    respond_to do |format|
      format.json { render json: { showtimes: @showtimes }, status: :ok }
    end
  end

  def show
    @showtime = Showtime.find(params[:id])
    respond_to do |format|
      format.json { render json: { showtime: @showtime }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    @showtime = Showtime.new(showtime_params)
    if @showtime.save
      respond_to do |format|
        format.json { render json: { showtime: @showtime }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @showtime.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @showtime = Showtime.find(params[:id])
    if @showtime.update(showtime_params)
      respond_to do |format|
        format.json { render json: { showtime: @showtime }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @showtime.errors }, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def destroy
    @showtime = Showtime.find(params[:id])
    @showtime.destroy
    respond_to do |format|
      format.json { render json: { message: 'Successfully deleted' }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  private

  def showtime_params
    params.require(:showtime).permit(:time_of_show, :movie_id)
  end
end
