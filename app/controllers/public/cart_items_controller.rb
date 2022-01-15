class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = CartItem.all
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
    # whereでログインユーザーのレコードを取り出す
    @current_user = CartItem.where(customer_id: current_customer)
    if  @current_user.find_by(item_id: @cart_item_new.item_id)
      # inside_cart_itemはカートの中の同じitem.idの列
      @inside_cart_item = @current_user.find_by(item_id: @cart_item_new.item_id)
      @inside_cart_item.amount += params[:cart_item][:amount].to_i
      @inside_cart_item.save
      redirect_to cart_items_path

    else
      @cart_item_new.save(amount: params[:cart_item][:amount].to_i)
      redirect_to cart_items_path
    end
  end



  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
