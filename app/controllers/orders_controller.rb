class OrdersController < ApplicationController
  #before_action :set_order, only: [:show]
  before_action :logged_in_admin_user, only: [:index]
  
  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
    #@orderdetails = Orderdetails.where(order_id: @order.id)
    #@products = Product.where(id: @orderdetails.product_id)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end
  
  # POST /orders
  def create
    
    @carts = Cart.where(user_id:current_user.id).order(created_at: :desc)
    @total_price = @carts.sum(:amount)

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
  
  private
  
  def set_order
    @order = Order.find(params[:id])
  end

end