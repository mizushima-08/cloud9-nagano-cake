class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    # private下で計算
    @total_price = total(current_customer)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item_new = CartItem.new(cart_item_params)
    @cart_item_new.customer_id = current_customer.id
    @cart_item_new.save
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end

  def total(price)
    total_price = 0
    price.cart_items.each do |cart_item|
      total_price += cart_item.amount * cart_item.item.price
    end
    return (total_price * 1.1).floor
  end
end
