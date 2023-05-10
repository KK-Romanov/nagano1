class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @postage = 800
    # @order.payment = params[:order][:payment]

  end

  def update
  #   order = Order.find(params[:id])
  # order_details = order.order_details
  # if order.order_status == "入金確認"
  # order_details.update_all(making_status: "製作待ち")
  # end
  # redirect_to admins_order_path(order.id)
  @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
    if @order.update(order_status_params)
      if @order.order_status.include?("入金確認")
         @order_details.update_all(making_status_i18n: "製作待ち")
      end
    flash[:success] = "制作ステータスを変更しました。"
    redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end
  
  
   private
   
  def order_params
    params.require(:order).permit(:delivery_postal_code, :delivery_address, :delivery_name,
    :payment, :total_payment, :postage,:order_status)
  end


end

