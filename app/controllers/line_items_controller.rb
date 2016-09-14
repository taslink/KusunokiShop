class LineItemsController < ApplicationController
  before_action :logged_in_admin_user, only: [:index, :show]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  def create
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_count_up
    li_e = LineItem.find(params[:id])
    li_c = LineItem.find_by(cart_id: li_e.cart_id, product_type: 'card')
    cart = Cart.find_by(id: li_e.cart_id)
    
    li_e.count += 1
    li_c.count += 1
    
    if li_e.count > 30 || li_c.count > 30
      redirect_to carts_url, flash: {notice: '一度に購入できるのは30セットまでです'}
    else
      begin
        ActiveRecord::Base.transaction do
          li_e.save
          li_c.save
          #raise "例外発生"
          cart.amount = (li_e.product.price * li_e.count) + (li_c.product.price * li_c.count) 
          cart.save
        end
          redirect_to carts_url
        rescue => e
        redirect_to carts_url, flash: {notice: '処理に失敗しました'}
      end
    end
  end
  
  def update_count_down
    li_e = LineItem.find(params[:id])
    li_c = LineItem.find_by(cart_id: li_e.cart_id, product_type: 'card')
    cart = Cart.find_by(id: li_e.cart_id)
    
    li_e.count -= 1
    li_c.count -= 1
    
    if li_e.count < 1 || li_c.count < 1
      redirect_to carts_url, flash: {notice: '0にする場合は「削除」してください'}
    else
      begin
        ActiveRecord::Base.transaction do
          li_e.save
          li_c.save
          #raise "例外発生"
          cart.amount = (li_e.product.price * li_e.count) + (li_c.product.price * li_c.count) 
          cart.save
        end
          redirect_to carts_url
        rescue => e
        redirect_to carts_url, flash: {notice: '処理に失敗しました'}
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id, :product_type, :count)
    end
end
