class Public::CustomersController < ApplicationController
  before_action :ensure_user, only: [:show, :edit, :update,]
  def show
    @customer = Customers.find(params[:id])
  end

  def edit
  end

  def update
  end

  def withdrawal
  end

  def switch
  end

end