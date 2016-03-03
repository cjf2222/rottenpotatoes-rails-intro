class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings= ['G','PG','PG-13','R']
    @rating=['G','PG','PG-13','R']
    if(params[:ratings].present?)
      @rating= params[:ratings].keys
      session[:rates]=@rating
    else
        if(session[:rates].present?)
          @rating=session[:rates]
        else
          session[:rates]=@rating
        end
    end
    @sorter="title"
    if(params[:sort].present?)
      @sorter=params[:sort]
      session[:current_sort]=@sorter
    else
        if(session[:current_sort].present?)
          @sorter=session[:current_sort]
        end
    end
    if @sorter == "title"
      @movies=Movie.where(rating: @rating).order("title")
      @style_t="hilite"
    elsif @sorter == "date"
      @movies=Movie.where(rating: @rating).order("release_date").reverse_order
      @style_d="hilite"
    else
      @movies=Movie.where(rating: @rating).order("release_date").reverse_order
      @style_t=""
      @style_d=""
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  
end
