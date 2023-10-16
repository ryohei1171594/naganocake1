class Admin::OrderItemsController < ApplicationController
    def update
      @order_detail = OrderDetail.find(params[:id])
      @order_detail.update(order_item_params)
      @order = @order_detail.order
      is_updated = true
      if @order_detail.update(order_item_params)
         @order_details.each do |order_detail| 
          if order_detail.status != "finish"
            is_updated = false 
          end
         end
      end
      @order.update(status: "preparing_ship") if is_updated
      redirect_to admin_order_path(@order)
    end
    
    private
    def order_item_params
      params.require(:order_item).permit(:status)
    end
end
