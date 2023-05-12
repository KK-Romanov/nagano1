class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = @order.order_details
    @postage = 800
    @production_status = @order.order_details.pluck(:production_status_i18n)
    
    @total = 0
    @order_details.each do |order_detail|
      @total += order_detail.amount * order_detail.tax_price 
    end
    #  += 
    # @sum = 0
    # each do 編成
    # @total = 3
    # @sum + @total = 3
    # @sum = 3
    # @sum + @total = 6
    #簡易文 @total= @total + order_detail.amount * order_detail.tax_price 
  end

  def update
  @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
    if @order.update(order_status_params)
      if @order.order_status.include?("入金確認")
         @order_details.update(production_status_i18n: "1")
      end
    flash[:success] = "制作ステータスを変更しました。"
    redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end
  
  
   private
  def order_status_params
    params.require(:order).permit(:order_status)
  end
end  
  # def order_params
  #   params.require(:order).permit(:delivery_postal_code, :delivery_address, :delivery_name,
  #   :payment, :total_payment, :postage,:order_status)


