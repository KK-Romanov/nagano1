class Admin::GenresController < ApplicationController
  def index
    # @genres = Genres.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    # @genre.item_id = item.id
    if @genre.save
       flash[:notice] = "successfully"
         redirect_to index
    else
        @items = Item.all  
        flash[:notice] = "error"
        render :index
    end
  end

  def edit
    @genre = @Genre.find(params[:id])
  end

  def update
    @genre = @Genre.find(params[:id])
    if @genre.update(item_params)
        flash[:notice] = "successfully"  
        redirect_to index  
    else 
        flash[:notice] = "error"  
        render :index
    end
  end
  
  private
     def genre_params
        params.require(:genre).permit(:name) 
     end
  


end
