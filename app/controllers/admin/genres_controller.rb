class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    # @genre.item_id = item.id
    if @genre.save
      flash[:notice] = "successfully"
        redirect_to admin_genres_path
    else
        @genres = Genre.all  
        flash[:notice] = "error"
        render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    # if @genre.update(genre_params)
    #     flash[:notice] = "successfully"  
    #     redirect_to admin_genres
    # else 
    #     flash[:notice] = "error"  
    #     render :edit
    # end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
        flash[:notice] = "successfully"  
        redirect_to admin_genres_path
    else 
        flash[:notice] = "error"  
        render :edit
    end
  end
  
  private
     def genre_params
        params.require(:genre).permit(:name ) 
     end
  


end
