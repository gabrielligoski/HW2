# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    session[:sort_by] = params[:sort_by]
    session[:ratings] = params[:ratings]
    if session[:ratings] == nil
      session[:ratings] = {'G': '1', 'PG': '1', 'PG-13': '1', 'NC-17': '1', 'R': '1'}
    end
    # id = params[:id]
    @movies = Movie.where(rating: session[:ratings].keys).order(session[:sort_by]).all
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end


  def new
    @movie = Movie.new
  end

  def create
    #@movie = Movie.create!(params[:movie]) #did not work on rails 5.
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title,:rating,:description,:release_date)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    #@movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])#did not work on rails 5.
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end
end