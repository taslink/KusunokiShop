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
  
  # 手動作成
  def update_count_up
    li_a = LineItem.find(params[:id])
    li_b = LineItem.find_by(cart_id: li_a.cart_id, product_type: 'card')
    cart_item = Cart.find_by(id: li_a.cart_id)
    
    li_a.count += 1
    li_b.count += 1
    li_a.save
    li_b.save
    cart_item.amount = (li_a.product.price * li_a.count) + (li_b.product.price * li_b.count) 
    cart_item.save
    
    redirect_to controller: 'carts', action: 'index'
  end
  
  def update_count_down
    li_a = LineItem.find(params[:id])
    li_b = LineItem.find_by(cart_id: li_a.cart_id, product_type: 'card')
    cart_item = Cart.find_by(id: li_a.cart_id)
    
    li_a.count -= 1
    li_b.count -= 1
    li_a.save
    li_b.save
    
    cart_item.amount = (li_a.product.price * li_a.count) + (li_b.product.price * li_b.count) 
    cart_item.save
    
    redirect_to controller: 'carts', action: 'index'
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
