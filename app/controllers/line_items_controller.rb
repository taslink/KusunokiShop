class LineItemsController < ApplicationController

  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all.order(id: :asc)
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
    
    envelope_id = params["envelope_id"]
    card_id = params["card_id"]

    envelope_count = params["count"].to_i
    card_count = params["count"].to_i
      
    envelope = Product.find(envelope_id)
    card = Product.find(card_id)
      
    amount = (envelope.price * envelope_count) + (card.price * card_count)
      
    if envelope_count == 0 || card_count == 0
      redirect_to envelope, flash: {notice: 'セット数を入力してください。'}
    else
      begin
        ActiveRecord::Base.transaction do
          
          @cart = current_cart
          
          cart_pocket = CartPocket.create!(cart_id:@cart.id, amount:amount)
          #raise "例外発生"
          LineItem.create!(product_id:envelope_id, cart_pocket_id:cart_pocket.id, product_type:"envelope",count:envelope_count)
          LineItem.create!(product_id:card_id, cart_pocket_id:cart_pocket.id, product_type:"card",count:card_count)
        end
          redirect_to carts_path, flash: {notice: 'カートに入れました'}
        rescue => e
        redirect_to envelope, flash: {notice: '処理に失敗しました。お手数ですがもう一度お願いします。'}
      end
    end
    
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
    li_c = LineItem.find_by(cart_pocket_id: li_e.cart_pocket_id, product_type: 'card')
    cart_pocket = CartPocket.find_by(id: li_e.cart_pocket_id)
    
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
          cart_pocket.amount = (li_e.product.price * li_e.count) + (li_c.product.price * li_c.count) 
          cart_pocket.save
        end
          redirect_to carts_url, flash: {notice: '数量を増やしました'}
        rescue => e
        redirect_to carts_url, flash: {notice: '処理に失敗しました'}
      end
    end
  end
  
  def update_count_down
    li_e = LineItem.find(params[:id])
    li_c = LineItem.find_by(cart_pocket_id: li_e.cart_pocket_id, product_type: 'card')
    cart_pocket = CartPocket.find_by(id: li_e.cart_pocket_id)
    
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
          cart_pocket.amount = (li_e.product.price * li_e.count) + (li_c.product.price * li_c.count) 
          cart_pocket.save
        end
          redirect_to carts_url, flash: {notice: '数量を減らしました'}
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
