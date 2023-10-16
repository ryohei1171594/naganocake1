class Admin::OrdersController < ApplicationController
    def index
    end
    
    def show
      @order_details = OrderDetail.where(order_id: params[:id])
      @order = Order.find(params[:id])
      @order.address = @order.customer.address
      Order.where(order_id:params[:id])
    end
    
    def update
      @order_details = OrderDetail.where(order_id: params[:id])
      @order = Order.find(params[:id])
      if @order.update!(order_params)
         @order_details.update_all(status: "waiting_manufacture") if @order.status == "confirm_payment"
         @order_details.update_all(status: "finish") if @order.status == "prepairing_ship"
      end
      redirect_to admin_order_path(@order)
    end
    
    private
    def order_params
      params.require(:order).permit(:status)
    end
end
