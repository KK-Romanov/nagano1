class Public::HomesController < ApplicationController
  def top
    @item = Item.new
    @items = Item.all.order(created_at: :desc)
  
  end

  def about
  end
  
  private
	def item_params
      params.require(:item).permit(:image ,:name, :price)
	end


end
