class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customers.find(params[:id])
    @customer.update(customer_params)
    redirect_to  customer.current_customer_path
  end

  def withdrawal
    @customer = current_customer
  end

  def switch
  end

  private
  def customer_params
  	  params.require(:customer).permit(:is_active, :last_name, :first_name, :last_name_kana, :first_name_kana,
  	                                   :telephone_number, :email, :password, :postal_code, :address)
  end

end