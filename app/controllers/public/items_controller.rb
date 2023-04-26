class Public::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
  end

  def show
     @item = Item.find(params[:id])
  end
end

private
     def item_params
        params.require(:item).permit(:name, :introduction, :image, :price) 
     end