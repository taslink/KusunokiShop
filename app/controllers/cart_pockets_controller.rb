class CartPocketsController < ApplicationController
  before_action :set_cart_pocket, only: [:destroy]
  
  # DELETE /cart_pockets
  def destroy
    @cart_pocket.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: '削除しました。' }
      format.json { head :no_content }
    end
  end
  
  private

  def set_cart_pocket
    @cart_pocket = CartPocket.find(params[:id])
  end
  
end
