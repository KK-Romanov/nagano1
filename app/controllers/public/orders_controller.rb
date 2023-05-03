class Public::OrdersController < ApplicationController
  def new
    @order = Oder.new
    @customer = current_customer
    @cart_items = current_customer.cart_items
  end

  def confirm
    @order = Oder.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  def complete
  end

  def create
    @order = Oder.new(order_params)
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
    oders = current_customer.oders
  end

  def show
    @order = Oder.find(params[:id])
		@order_details = @order.order_details
  end
  
  def order_params
  params.require(:order).permit(:customer_id, :delivery_postal_code, :delivery_address, :delivery_name,
    :payment, :total_payment, :postage, :order_status)
  end

end
