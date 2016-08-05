class ProductsController < ApplicationController

  def show
  end
  
  private
  def set_product
    @product = Product.find(params[:id])
  end
end
