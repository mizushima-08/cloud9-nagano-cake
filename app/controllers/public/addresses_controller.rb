class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @address_new = Address.new
    # ログインユーザーのaddressのみ表示
    @addresses = current_customer.addresses
  end

  def create
    @address_new = Address.new(address_params)
    # addressデータのcustomer.idタグにログインユーザーを登録する
    @address_new.customer_id = current_customer.id
    @address_new.save
    redirect_to addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
