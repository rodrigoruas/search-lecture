class MoviesController < ApplicationController
  def index
    if params[:query]

      # SELECT * FROM movies WHERE title = 'Superman'

      #exact match
      @movies = Movie.where(title: params[:query])

      # any movie that have superman anywhere in the title
       # SELECT * FROM movies WHERE title LIKE '%Superman%'

       # easily hacked -> sql injection 
      #@movies = Movie.where("title LIKE %#{params[:query]}%")

      @movies = Movie.where("title LIKE ?", "%#{params[:query]}%")

      # ILIKE -> insensitve LIKE
      @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")

      # search on movie's title and synopsis
      @movies = Movie.where("title ILIKE ? OR synopsis ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")

      @movies = Movie.where("title ILIKE :search OR synopsis ILIKE :search", search: "%#{params[:query]}%")

      #search for movies that the director is Nolan
      
      @movies = Movie.perform_search(params[:query])



    else 
      #' display all movies
      @movies = Movie.all
    end
  end
end






































      # # search for exact match
      #@movies = Movie.where(title: params[:query])

      # # search for any title containing the query
      # @movies = Movie.where("title LIKE ?", "%#{params[:query]}%")

      # # search for any title containing the query -> case insensitive
      # @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")

      # #search in multiple columns
      # #@movies = Movie.where("title ILIKE ? OR syllabus ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")

      # @movies = Movie.where("title ILIKE :query OR syllabus ILIKE :query", query: "%#{params[:query]}%")

      # # search for directors name -> Nolan

      # sql_query = "
      #   movies.title ILIKE :query
      #   OR movies.syllabus ILIKE :query
      #   OR directors.first_name ILIKE :query
      #   OR directors.last_name ILIKE :query
      #   "
      #  @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # # multiple search term - POSTGRESQL

      # sql_query = "
      #   movies.title @@ :query
      #   OR movies.syllabus @@ :query
      #   OR directors.first_name @@ :query
      #   OR directors.last_name @@ :query
      #   "
      #  @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%"
      # @movies = Movie.search_by_title_and_synopsis(params[:query])
    # else