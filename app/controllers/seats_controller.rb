class SeatsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @seats = Seat.all
    respond_to do |format|
      format.json {render json: {seats: @seats}, status: :ok }
    end
  end 

  def show
    begin
      @seat = Seat.find(params[:id])
      respond_to do |format|
        format.json {render json: {seat: @seat}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def create
    @seat = Seat.new(seat_params)
    if @seat.save
      respond_to do |format|
        format.json {render json: {seat: @seat}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @seat.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @seat = Seat.find(params[:id]) 
      if @seat.update(seat_params)  
        respond_to do |format|
          format.json {render json: {seat: @seat}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @seat.errors}, status: :unprocessable_entity}
        end
      end   
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end    
  end
  
  def destroy
    begin
      @seat = Seat.find(params[:id])
      @seat.destroy
      respond_to do |format|
        format.json {render json: {message: 'Successfully deleted'}, status: :ok}
      end  
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def seat_params
      params.require(:seat).permit(:type_of_seat, :theatre_id, :auditorium_id, :viewer_id)
    end
end