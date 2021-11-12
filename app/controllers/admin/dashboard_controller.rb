class Admin::DashboardController < ApplicationController
  def show
    @products = Product.all
    @category = Category.all
  end
end
