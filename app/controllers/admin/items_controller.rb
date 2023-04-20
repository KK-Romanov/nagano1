class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end


  def index
    @items = Item.all
    
  end


  def create
     @item = Item.new(item_params)
        # @book.user_id = current_user.id
        # @customer = current_custumer.id
     if @item.save
         flash[:notice] = "successfully"
         redirect_to admin_items_path
     else
        @items = Item.all  
        flash[:notice] = "error"
        render :admin_zaku_path
     end
  end


  def show
     @item = Item.find(params[:id])
  end


  def edit
      @item = Item.find(params[:id])

  end

  def update
    @item = Item.find(params[:id])
     if @item.update(item_params)
        flash[:notice] = "successfully"  
        redirect_to admin_items_path  
     else 
        flash[:notice] = "error"  
        render :edit
     end
  end

private
     def item_params
        params.require(:item).permit(:name, :introduction, :image, :price, :is_active) 
     end
  

end
