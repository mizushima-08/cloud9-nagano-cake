class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
  def show
    @customer = Customer.find(params[:id])
  end
  def edit
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to  admin_customers_path
  end

  private
  def customer_params
    params.require(:customer).permit(:is_active, :last_name, :first_name, :last_name_kana,
    :first_name_kana, :telephone_number, :email, :password, :postal_code, :address)
  end
end
