class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new
    
  end

  def update
    cart_items = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
  end

  def destroy
     cart_items = CartItem.find(params[:id])
    # @cart_item.destroy
  end

  def destroy_all
    # current_user.cart_items.destroy_all
     if cart_item.destroy_all
       redirect_to cart_items_path
     end
  end

  def create
    
    @cart_item = CartItem.new(cart_item_params) # 空のモデルを作成（ストロングパラメーターが必要）
    @cart_item.customer_id = current_customer.id # 親モデルのidを指定
    @cart_item.save! # 保存する
    
    
    # @cart_items = current_customer.cart_items
    # if @
     redirect_to cart_items_path
    # binding.pry
  end
    private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
