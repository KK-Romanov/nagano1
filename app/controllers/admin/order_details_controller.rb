class Admin::OrderDetailsController < ApplicationController

def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])

    is_updated = true
    
    if @order_detail.update(order_detail_params)
       #ステータス変更処理　
      if order_detail_params[:production_status] == "in_production" 
       @order.update(order_status: 2)
      end
      @order.order_details.each do |order_detail|
        if order_detail.production_status != "production_complete"
          is_updated = false
        end
       end
        @order.update(order_status: 3) if is_updated
         
    end
      flash[:success] = "制作ステータスを変更しました。"
      redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
