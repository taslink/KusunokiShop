class OrdersController < ApplicationController
  #before_action :set_order, only: [:show]
  before_action :logged_in_admin_user, only: [:index]
  
  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
    @orderdetails = Orderdetails.where(order_id: @order.id)
    @products = Product.where(id: @orderdetails.product_id)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end
  
  # POST /orders
  def create
    
    envelope_id = params["envelope_id"]
    card_id = params["card_id"]
    
    @envelope_count = params["envelope_count"].to_i
    @card_count = params["card_count"].to_i
    
    @envelope = Product.find(envelope_id)
    @card = Product.find(card_id)
    
    price = (@envelope.price * @envelope_count) + (@card.price * @card_count)
    
    if @envelope_count == 0
      redirect_to @envelope, flash: {notice: '封筒の数を入力してください。'}
    elsif @card_count == 0
      redirect_to @envelope, flash: {notice: 'カードの数を入力してください。'}
    elsif @envelope_count > @card_count
      redirect_to @envelope, flash: {notice: 'セット販売の為、封筒とカードを同数ご購入ください。書き損じ用などでカードを多く購入することは可能です。'}
    else
      
    begin
      ActiveRecord::Base.transaction do
        @order = Order.create!(user_id:current_user.id, total_price:price)
        Orderdetail.create!(product_id:envelope_id, product_type:"envelope",count:@envelope_count, order_id:@order.id)
        #raise "例外発生"
        Orderdetail.create!(product_id:card_id, product_type:"card",count:@card_count, order_id:@order.id)
      end
        #redirect_to @order
        render :show
      rescue => e
      redirect_to @envelope, flash: {notice: '処理に失敗しました。お手数ですがもう一度お願いします。'}
    end
      
    end
    
  end
  
  private
  
  def set_order
    @order = Order.find(params[:id])
  end

end