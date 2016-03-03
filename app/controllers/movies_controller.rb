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
    if(params[:ratings].present?)  # check if its in params
      @rating= params[:ratings].keys #if it is, add it 
      session[:rates]=@rating       #if not add to session instead
    else
        if(session[:rates].present?)  #check if its in session
          @rating=session[:rates]     # if it is add it
        else
          session[:rates]=@rating    # if not, use session data instead
        end
    end
    
    
    @sorter="title"                  # same as rating but for sort
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
      @style_a="hilite"
      
      #brought the hilite out of views into styles
    elsif @sorter == "date"
      @movies=Movie.where(rating: @rating).order("release_date").reverse_order
      @style_b="hilite"
      
    else
      @movies=Movie.where(rating: @rating).order("release_date").reverse_order
      @style_a=""
      @style_b=""
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
