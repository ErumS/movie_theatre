class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @movies = Movie.all
    respond_to do |format|
      format.json { render json: { movies: @movies }, status: :ok }
    end
  end

  def show
    @movie = Movie.find(params[:id])
    respond_to do |format|
      format.json { render json: { movie: @movie }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      respond_to do |format|
        format.json { render json: { movie: @movie }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @movie.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      respond_to do |format|
        format.json { render json: { movie: @movie }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @movie.errors }, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    respond_to do |format|
      format.json { render json: { message: 'Successfully deleted' }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :rating, :cast, :duration, :theatre_id)
  end
end
