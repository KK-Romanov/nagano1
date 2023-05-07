class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    # @delivery_addresses = current_customer.delivery_addresseses
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @cart_items = current_customer.cart_items
    @order.customer_id = current_customer.id
    @order.payment = params[:order][:payment]
    @postage = 800
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # binding.pry
    @order.save!
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item_id
      order_detail.amount = cart_item.amount
      order_detail.tax_price = cart_item.item.price * 1.08
      order_detail.save 
    end  
    @cart_items.destroy_all
    redirect_to orders_complete_path
    
   
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def order_params
  params.require(:order).permit(:delivery_postal_code, :delivery_address, :delivery_name,
    :payment, :total_payment, :postage, :order_status)
  end

end
