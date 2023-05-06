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
    # @order.address = current_customer.address
    # @order.name = current_customer.first_name + current_customer.last_name
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save!
      @cart_items = current_customer.cart_products
      @cart_products.destroy_all
      redirect_to orders_complete_path
    else
      render "new"
    end
    
  end

  def index
    @orders = current_customer.orders
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  # @order_details = @order.order_details
  end
  
  def order_params
  params.require(:order).permit(:customer_id, :delivery_postal_code, :delivery_address, :delivery_name,
    :payment, :total_payment, :postage, :order_status)
  end

end
