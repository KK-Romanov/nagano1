class Public::HomesController < ApplicationController
  def top
    @item = Item.new
    @items = Item.all
  
  end

  def about
  end
  
  private
	def item_params
      params.require(:item).permit(:image ,:name, :price)
	end


end
