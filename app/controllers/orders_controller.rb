class OrdersController < ApplicationController
  
  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end
  
  # POST /orders
  def create
    envelope_id = params["envelope_id"]
    card_id = params["card_id"]
    
    envelope_count = params["envelope_count"].to_i
    card_count = params["envelope_count"].to_i
    
    envelope = Product.find(envelope_id)
    card = Product.find(card_id)
    
    price = (envelope.price * envelope_count) + (card.price * card_count)
    
    order = Order.create(user_id:current_user.id, total_price:price)
    Orderdetail.create(product_id:envelope_id, product_type:"envelope",count:envelope_count, order_id:order.id)
    Orderdetail.create(product_id:card_id, product_type:"card",count:card_count, order_id:order.id)
    render :show

  end

end
