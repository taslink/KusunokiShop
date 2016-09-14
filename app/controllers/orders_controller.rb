class OrdersController < ApplicationController
  before_action :logged_in_admin_user, only: [:index]
  before_action :set_order, only: [:show, :edit, :update,:destroy]
  
  # coding: utf-8
  
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
    @add_amount = @cart_to_orders.sum(:amount).to_i
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
    cart_to_orders = current_user.carts.order(created_at: :asc)
    amount = cart_to_orders.sum(:amount).to_i
    tax = (amount * 0.08).floor
    if amount < 3000
      postage = 540
    else
      postage = 0      
    end
    
    address = params[:address]
    addressee = address['addressee']
    zipcode = address['zipcode']
    prefecture = address['prefecture']
    city = address['city']
    street = address['street']
    building = address['building']
    check_user_id = address['check_user_id']
    
    if check_user_id == "true"
      address_reg = Address.create!(user_id:current_user.id, addressee:addressee, zipcode:zipcode, prefecture:prefecture, city:city, street:street, building:building)
      order_reg = Order.create!(user_id:current_user.id, address_id:address_reg.id, amount:amount, tax:tax, postage:postage)
      
      cart_to_orders.LineItem.each do |li| 
       LineItem.create!(product_id:li.id, order_id:order_reg.id, product_type:li.product_type, count:li.count) 
      end
      
    end
    redirect_to order_reg
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