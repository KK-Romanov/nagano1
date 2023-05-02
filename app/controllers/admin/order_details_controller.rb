class Admin::OrderDetailsController < ApplicationController
  def update
    OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)

  end
  params.require(:order_detail).permit(:production_status)
end
