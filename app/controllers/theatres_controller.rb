class TheatresController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @theatres = Theatre.all
    respond_to do |format|
      format.json {render json: {theatres: @theatres}, status: :ok }
    end
  end 

  def show
    begin
      @theatre = Theatre.find(params[:id])
      respond_to do |format|
        format.json {render json: {theatre: @theatre}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def create
    @theatre = Theatre.new(theatre_params)
    if @theatre.save
      respond_to do |format|
        format.json {render json: {theatre: @theatre}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @theatre.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @theatre = Theatre.find(params[:id]) 
      if @theatre.update(theatre_params)  
        respond_to do |format|
          format.json {render json: {theatre: @theatre}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @theatre.errors}, status: :unprocessable_entity}
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
      @theatre = Theatre.find(params[:id])
      @theatre.destroy
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
    def theatre_params
      params.require(:theatre).permit(:name, :address, :phone_no)
    end
end