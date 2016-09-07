class CartsController < ApplicationController
  before_action :set_cart, only: [:edit, :update, :destroy]
  
  include SessionsHelper

  # GET /carts
  def index
    
    unless logged_in?
      store_location
      redirect_to login_url, flash: {notice: 'ご利用には会員登録が必要です'}

    else
    #@carts = Cart.where(user_id:current_user.id).order(created_at: :desc)
    @carts = current_user.carts.order(created_at: :desc)
    @add_amount = @carts.sum(:amount)
    @tax = (@add_amount * 0.08).floor
    if @add_amount < 3000
      @postage = 540
    else
      @postage = 0      
    end
    @total_amount = @add_amount + @tax + @postage
    
    end
  end

  # GET /carts/1
  def show
    @cart = Cart.find(params[:id])
    @line_items = LineItem.where(cart_id: params[:id])
    
    @li_envelope = @line_items.find_by(product_type: 'envelope')
    @li_card = @line_items.find_by(product_type: 'card')
    
    @envelope = Product.find_by(id: @li_envelope.product_id)
    @card = Product.find_by(id: @li_card.product_id)
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  def create
    
    unless logged_in?
      store_location
      redirect_to login_url, flash: {notice: 'ご利用には会員登録が必要です'}

    else
      
      envelope_id = params["envelope_id"]
      card_id = params["card_id"]
      
      @envelope_count = params["count"].to_i
      @card_count = params["count"].to_i
      
      @envelope = Product.find(envelope_id)
      @card = Product.find(card_id)
      
      amount = (@envelope.price * @envelope_count) + (@card.price * @card_count)
      
      if @envelope_count == 0 || @card_count == 0
        redirect_to @envelope, flash: {notice: 'セット数を入力してください。'}
      else
        begin
          ActiveRecord::Base.transaction do
            @cart_item = Cart.create!(user_id:current_user.id, amount:amount)
            LineItem.create!(product_id:envelope_id, product_type:"envelope",count:@envelope_count, cart_id:@cart_item.id)
            #raise "例外発生"
            LineItem.create!(product_id:card_id, product_type:"card",count:@card_count, cart_id:@cart_item.id)
          end
            redirect_to @cart_item
            #render :show
          rescue => e
          redirect_to @envelope, flash: {notice: '処理に失敗しました。お手数ですがもう一度お願いします。'}
        end
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.fetch(:cart, {})
    end
end
