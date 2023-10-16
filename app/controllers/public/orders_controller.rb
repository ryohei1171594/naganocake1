class Public::OrdersController < ApplicationController
    def index
      @orders = Order.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
    end
    
    def show
      @order_details = OrderDetail.where(order_id: params[:id])
      @order = Order.find(params[:id])
      @order.customer_id = current_customer.id
      Order.where(order_id:params[:id])
    end
    
    def new
      @order = Order.new
      @addresses = current_customer.addresses
    end
    
  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
    @sum = 0
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.with_tax_price
      @order_details.amount = cart_item.amount
      @order_details.status = 0
      if @order_details.save!
      cart_item.destroy
      else
      redirect_to public_cart_items_path
      end
    end
    redirect_to public_orders_complete_path
  end
  
    def destroy_all
      @cart_items = current_customer.cart_items.all
      @cart_items.destroy
      redirect_to public_cart_items_destroy_all_path
    end
  

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    else params[:order][:select_address] == "1"
       #@order.name = current_customer.first_name + current_customer.last_name
    end
  end

private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :billing, :customer_id , :status)
  end
  
  def cartitem_nill
     cart_items = current_customer.cart_items
     if cart_items.blank?
      redirect_to cart_items_path
     end
  end
end