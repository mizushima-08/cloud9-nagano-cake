class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:id] # 会員詳細から来た場合
      @orders = Customer.find(params[:id]).orders.page(params[:page]).per(10)
    else
      @orders = Order.page(params[:page]).per(10)
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def order_status_update
    @order = Order.find(params[:order][:id])
    # ステータスの変更
    status_change_to_1 = @order.order_status_was == "waiting_deposit" and @order.order_status == "confirmation"
    @order.update(order_params)
    @order.product_orders.update_all(production_status: "waiting_production") if status_change_to_1
    redirect_to request.referer
  end

  def item_status_update
    @product_order = ProductOrder.find(params[:product_order][:id])
    @product_order.update(product_order_params)
    @product_order_all = @product_order.order.product_orders
    if @product_order_all.where(production_status: "production_completed").count == @product_order_all.count
      @product_order.order.update(order_status: "ready_ship")
    elsif @product_order.production_status == "production"
      @product_order.order.update(order_status: "production")
    end
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
