class OrdersController < ApplicationController
  before_action :logged_in_admin_user, only: [:index]
  before_action :set_order, only: [:show, :edit, :update,:destroy]
  
  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @cart_to_orders = current_user.carts.order(created_at: :desc)
    @add_amount = @cart_to_orders.sum(:amount)
    @tax = (@add_amount * 0.08).floor
    if @add_amount < 3000
      @postage = 540
    else
      @postage = 0      
    end
    @total_amount = @add_amount + @tax + @postage
  end

  # GET /orders/1/edit
  def edit
  end
  
  # POST /orders
  def create
    

    begin
      ActiveRecord::Base.transaction do
        @order = Order.create!(user_id:current_user.id, total_price:@total_price)
        #Orderdetail.create!(product_id:envelope_id, product_type:"envelope",count:@envelope_count, order_id:@order.id)
        #raise "例外発生"
        #Orderdetail.create!(product_id:card_id, product_type:"card",count:@card_count, order_id:@order.id)
      end
        #redirect_to @order
        render :show
      rescue => e
      redirect_to @order, flash: {notice: '処理に失敗しました。お手数ですがもう一度お願いします。'}
    end

  end
  
  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
       redirect_to @order, notice: 'Cart was successfully updated.'
    else
       render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end
  
  
  private
  
  def set_order
    @order = Order.find(params[:id])
  end

end