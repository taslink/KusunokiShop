class OrdersController < ApplicationController
  
  def add
    render :show
  end

  
  
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
  
  # POST /users
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end
  
end
