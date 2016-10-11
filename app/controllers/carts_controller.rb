class CartsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create]
  before_action :set_cart, only: [:edit, :update, :destroy]
  
  include SessionsHelper

  # GET /carts
  def index
    @carts = current_user.carts.order(created_at: :desc)
    
    if current_user.payment_type == "payment01"
      @payment_type = "代金引換"
    elsif current_user.payment_type == "payment02"
      @payment_type = "クレジットカード他"
    end
    
    if current_user.shipping_type == "takkyubin"
      @shipping_type = "宅急便"
    elsif current_user.shipping_type == "nekoposu"
      @shipping_type = "ポスト投函便"
    end
    
    if current_user.shipping_prefecture == "everyplace"
      cu_prefecture = "everyplace"
    else
      cu_prefecture = current_user.shipping_prefecture.to_i
    end
    
    if cu_prefecture == "everyplace"
      @shipping_prefecture = "全国一律、送料450円"
    else
      prefecture = Prefecture.find_by(id: cu_prefecture)
      unless prefecture.nil?
        @shipping_prefecture = prefecture.name
      end
    end    
    
    @items_amount = @carts.sum(:amount)
    
    if  current_user.payment_type == "payment01"
      @pay_commission = 300
      if cu_prefecture == 1
        @postage = 1400
      elsif cu_prefecture == 2 || cu_prefecture == 3 || cu_prefecture == 5
        @postage = 1000
      elsif cu_prefecture == 4 || cu_prefecture == 6 || cu_prefecture == 7
        @postage = 900      
      elsif cu_prefecture >= 8 && cu_prefecture <= 15
        @postage = 800
      elsif cu_prefecture == 19 || cu_prefecture == 20
        @postage = 800
      elsif cu_prefecture == 16 || cu_prefecture == 17 || cu_prefecture == 18
        @postage = 700   
      elsif cu_prefecture >= 19 && cu_prefecture <= 35
        @postage = 700
      elsif cu_prefecture >= 36 && cu_prefecture <= 46
        @postage = 800
      elsif cu_prefecture == 47
        @postage = 1200
      end
    elsif current_user.payment_type == "payment02"
      @pay_commission = 0
      @postage = 450
    else
      @pay_commission = 0
      @postage = 0      
    end
    
    if @items_amount >= 1800 && @items_amount < 3600 
      @pay_commission = @pay_commission / 2
      @postage = @postage / 2
    elsif @items_amount >= 3600
      @pay_commission = 0
      @postage = 0    
    end
    
    @add_amount = @items_amount + @pay_commission + @postage
    @tax = (@add_amount * 0.08).floor
    @total_amount = @add_amount + @tax
    
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
          LineItem.create!(product_id:envelope_id, cart_id:@cart_item.id, product_type:"envelope",count:@envelope_count)
          #raise "例外発生"
          LineItem.create!(product_id:card_id, cart_id:@cart_item.id, product_type:"card",count:@card_count)
        end
          redirect_to @cart_item
          #render :show
        rescue => e
        redirect_to @envelope, flash: {notice: '処理に失敗しました。お手数ですがもう一度お願いします。'}
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
