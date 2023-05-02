class Public::OrdersController < ApplicationController
  def new
    @cart_items = current_customer.cart_items
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  def complete
  end

  def create
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
		@order_details = @order.order_details
  end
  
  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
