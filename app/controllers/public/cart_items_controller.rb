class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new
    
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    current_customer.cart_items.find(params[:id]).destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    # current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
     

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.update(amount: @cart_item.amount + params[:cart_item][:amount])
    else
      @cart_item = CartItem.new(cart_item_params) # 空のモデルを作成（ストロングパラメーターが必要）
      @cart_item.customer_id = current_customer.id # 親モデルのidを指定
      @cart_item.item_id = params[:cart_item][:item_id]
      # binding.pry
      @cart_item.save! # 保存する
      
    end
    
    
    
    # @cart_items = current_customer.cart_items
    # if @
     redirect_to cart_items_path
    # binding.pry
  end
  
  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
  
end
