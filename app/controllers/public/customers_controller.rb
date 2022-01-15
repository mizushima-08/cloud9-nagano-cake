class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to  customer_path(current_customer)
  end

  def withdrawal
    @customer = current_customer
  end

  def switch
    @customer = current_customer
    if @customer.update(is_active: false)
      sign_out current_customer #URLを踏ませずにコントローラーから直接サインアウトの指示を出す（device公式)
    end
    redirect_to root_path

  end

  private
  def customer_params
    params.require(:customer).permit(:is_active, :last_name, :first_name, :last_name_kana,
    :first_name_kana, :telephone_number, :email, :password, :postal_code, :address)
  end

end