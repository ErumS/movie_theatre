class BookingsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @bookings = Booking.all
    respond_to do |format|
      format.json {render json: {bookings: @bookings}, status: :ok }
    end
  end 

  def show
    begin
      @booking = Booking.find(params[:id])
      respond_to do |format|
        format.json {render json: {booking: @booking}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      respond_to do |format|
        format.json {render json: {booking: @booking}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @booking.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @booking = Booking.find(params[:id]) 
      if @booking.update(booking_params)  
        respond_to do |format|
          format.json {render json: {booking: @booking}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @booking.errors}, status: :unprocessable_entity}
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
      @booking = Booking.find(params[:id])
      @booking.destroy
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
    def booking_params
      params.require(:booking).permit(:booking_type, :no_of_bookings, :theatre_id, :movie_id, :auditorium_id, :viewer_id, :showtime_id)
    end
end