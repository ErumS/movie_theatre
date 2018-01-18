class TicketsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @tickets = Ticket.all
    respond_to do |format|
      format.json {render json: {tickets: @tickets}, status: :ok }
    end
  end 

  def show
    begin
      @ticket = Ticket.find(params[:id])
      respond_to do |format|
        format.json {render json: {ticket: @ticket}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      respond_to do |format|
        format.json {render json: {ticket: @ticket}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @ticket.errors}, status: :unprocessable_entity}
      end
    end    
  end 

  def update
    begin
      @ticket = Ticket.find(params[:id]) 
      if @ticket.update(ticket_params)  
        respond_to do |format|
          format.json {render json: {ticket: @ticket}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @ticket.errors}, status: :unprocessable_entity}
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
      @ticket = Ticket.find(params[:id])
      @ticket.destroy
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
    def ticket_params
      params.require(:ticket).permit(:movie_date, :purchase_date, :price, :showtime_id, :viewer_id, :booking_id)
    end
end