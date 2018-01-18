class ViewersController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @viewers = Viewer.all
    respond_to do |format|
      format.json {render json: {viewers: @viewers}, status: :ok }
    end
  end 

  def show
    begin
      @viewer = Viewer.find(params[:id])
      respond_to do |format|
        format.json {render json: {viewer: @viewer}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def create
    @viewer = Viewer.new(viewer_params)
    if @viewer.save
      respond_to do |format|
        format.json {render json: {viewer: @viewer}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @viewer.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @viewer = Viewer.find(params[:id]) 
      if @viewer.update(viewer_params)  
        respond_to do |format|
          format.json {render json: {viewer: @viewer}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @viewer.errors}, status: :unprocessable_entity}
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
      @viewer = Viewer.find(params[:id])
      @viewer.destroy
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
    def viewer_params
      params.require(:viewer).permit(:name, :phone_no, :mode_of_payment, :theatre_id, :movie_id, :auditorium_id)
    end
end