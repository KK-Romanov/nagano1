class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    # @delivery_addresses = current_customer.delivery_addresseses
  end

  def confirm
    @order = Order.new(order_params)
    # @address = Address.find(params[:order][:address_id])
    @cart_items = current_customer.cart_items
    @order.customer_id = current_customer.id
    @order.payment = params[:order][:payment]
    @postage = 800
    select_address = params[:order][:select_address]
    if select_address == '0' 
      puts 'test1'
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.last_name + current_customer.first_name
    elsif select_address == '1'
      puts 'test2'
      address = Address.find(params[:order][:address_id])
      @order.delivery_postal_code = address.postal_code
       @order.delivery_address =  address.address
       @order.delivery_name =  address.name
    end
    unless @order.valid?
      flash[:danger] = "お届け先の内容に不備があります<br>・#{@order.errors.full_messages.join('<br>・')}"
      p @order.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @postage = 800
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
