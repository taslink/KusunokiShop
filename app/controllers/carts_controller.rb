class CartsController < ApplicationController
  #before_action :logged_in_user, only: [:index, :show, :new, :create]
  before_action :set_cart, only: [:edit, :update, :destroy]
  
  include SessionsHelper

  # GET /carts
  def index
    if session[:cart_id].nil?
      @cart = nil
      @cart_pockets = nil
    else
      @cart = Cart.find_by(id: session[:cart_id])
      @cart_pockets = CartPocket.where(cart_id: @cart).order(created_at: :desc)
      if @cart_pockets.empty?
        @cart.destroy
        @cart = nil
        session[:cart_id] = nil
      end
    end
    
    if session[:payment_type] == "payment01"
      @payment_type = "代金引換"
    elsif session[:payment_type] == "payment02"
      @payment_type = "クレジットカード他"
    end
    
    if session[:shipping_type] == "takkyubin"
      @shipping_type = "宅急便"
    elsif session[:shipping_type] == "nekoposu"
      @shipping_type = "ポスト投函便"
    end
    
    if session[:shipping_prefecture] == "everyplace"
      se_prefecture = "everyplace"
    else
      se_prefecture = session[:shipping_prefecture].to_i
    end
    
    if se_prefecture == "everyplace"
      @shipping_prefecture = "全国一律、送料450円"
    else
      prefecture = Prefecture.find_by(id: se_prefecture)
      unless prefecture.nil?
        @shipping_prefecture = prefecture.name
      end
    end
    
    if @cart_pockets.nil?
      @items_amount = 0
    else
      @items_amount = @cart_pockets.sum(:amount)
    end
    
    if  session[:payment_type] == "payment01"
      @pay_commission = 300
      if se_prefecture == 1
        @postage = 1400
      elsif se_prefecture == 2 || se_prefecture == 3 || se_prefecture == 5
        @postage = 1000
      elsif se_prefecture == 4 || se_prefecture == 6 || se_prefecture == 7
        @postage = 900      
      elsif se_prefecture >= 8 && se_prefecture <= 15
        @postage = 800
      elsif se_prefecture == 19 || se_prefecture == 20
        @postage = 800
      elsif se_prefecture == 16 || se_prefecture == 17 || se_prefecture == 18
        @postage = 700   
      elsif se_prefecture >= 19 && se_prefecture <= 35
        @postage = 700
      elsif se_prefecture >= 36 && se_prefecture <= 46
        @postage = 800
      elsif se_prefecture == 47
        @postage = 1200
      end
    elsif session[:payment_type] == "payment02"
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
    @carts = Cart.all
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
