class Admin::OrdersController < ApplicationController
  def index
    if params[:id] # 会員詳細から来た場合
      @orders = Customer.find(params[:id]).orders.all
    else
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def order_status_update
    @order = Order.find(params[:order][:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end

  def item_status_update
    @product_order = ProductOrder.find(params[:product_order][:id])
    @product_order.update(product_order_params)
    redirect_to admin_order_path(@product_order.order_id)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end

  def product_order_params
    params.require(:product_order).permit(:production_status)
  end
end
