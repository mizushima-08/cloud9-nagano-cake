class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @customer = current_customer
    @customer_address = Address.where(customer_id:[current_customer.id])
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.postage = 400
    session[:payment_method] = order_params[:payment_method]
    if order_params[:payment_method].nil? or params[:select_address].nil?
      redirect_to new_order_path
    else
      if params[:select_address] == "my_address"
        session[:postal_code] = current_customer.postal_code
        session[:address] = current_customer.address
        session[:name] = current_customer.first_name + current_customer.last_name
      elsif params[:select_address] == "selected_address"
        @address = Address.find(params[:order][:address_id])
        session[:postal_code] = @address.postal_code
        session[:address] = @address.address
        session[:name] = @address.name
      elsif params[:select_address] == "new_address"
        session[:postal_code] = order_params[:postal_code]
        session[:address] = order_params[:address]
        session[:name] = order_params[:name]
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.postal_code = session[:postal_code]
    @order.address = session[:address]
    @order.name = session[:name]
    @order.payment_method = session[:payment_method]
    @order.customer_id = current_customer.id
    @order.order_status = 0
    @order.save
    # order_detailの登録 商品が複数あるからeach
    @order.customer.cart_items.each do |i|
      @order_detail = @order.product_orders.build
      @order_detail.order_id = @order.id
      @order_detail.item_id = i.item.id
      @order_detail.price = (i.item.with_tax_price).floor
      @order_detail.amount = i.amount
      @order_detail.production_status = 0
      @order_detail.save
    end
    # カートをからに
    @order.customer.cart_items.destroy_all
    # セッション削除
    session[:payment_method].clear
    session[:name].clear
    session[:postal_code].clear
    session[:address].clear
    redirect_to order_thanks_path
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_price, :postage)
  end
end
