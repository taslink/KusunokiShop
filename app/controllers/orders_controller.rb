class OrdersController < ApplicationController
  before_action :logged_in_admin_user, only: [:index]
  #before_action :logged_in_order_user, only: [:show]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :store_location, only: [:new]
  
  # coding: utf-8
  
  # GET /orders
  def index
    @orders = Order.all.order(created_at: :desc)
  end

  # GET /orders/1
  def show
    @note = @order.note
  end

  # GET /orders/new
  def new
    @cart = Cart.find_by(id: session[:cart_id])
    @cart_pockets = CartPocket.where(cart_id: @cart).order(created_at: :desc)

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
    
    @items_amount = @cart_pockets.sum(:amount)
    
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

  # GET /orders/1/edit
  def edit
  end
  
  def note_update
    @order = Order.find(params["order_id"])
    note = params["note"]
    @order.update(note:note)
    redirect_to @order, flash: {notice: '備考欄を更新しました。'}
  end
  
  # POST /orders
  def create
    cart = Cart.find_by(id: session[:cart_id])
    cart_pockets = CartPocket.where(cart_id:cart).order(created_at: :desc)
    line_items = LineItem.where(cart_pocket_id:cart_pockets.ids).order(created_at: :asc)
    payment_type = params[:payment_type]
    amount = cart_pockets.sum(:amount).to_i
    shipping_type = params[:shipping_type] 
    pay_commission = params[:pay_commission].to_i
    
    if logged_in?
    #ログインしている場合↓↓
    @user_id = current_user.id
    
      if current_user.address.nil? 
      #ログインユーザーがアドレスを持っていない場合、アドレスを作成し指定↓↓
      
        address = params[:address]
        addressee = address['addressee']
        order_email = address['order_email']
        zipcode = address['zipcode']
        prefecture_name = address['prefecture_name']
        city = address['city']
        street = address['street']
        building = address['building']
        check_user_id = address['check_user_id']
        if check_user_id == "true"
          @address_reg = Address.create(user_id:@user_id, addressee:addressee, order_email:order_email, zipcode:zipcode, prefecture_name:prefecture_name, city:city, street:street, building:building)
        else
          @address_reg = Address.create(user_id:nil, addressee:addressee, order_email:order_email, zipcode:zipcode, prefecture_name:prefecture_name, city:city, street:street, building:building)
        end
        
      else
      #ログインユーザーがアドレスを持っている場合、そのアドレスを指定↓↓
        @address_reg = current_user.address
      end
      
      if @address_reg.addressee.empty? || @address_reg.order_email.empty? || @address_reg.zipcode.empty? || @address_reg.prefecture_name.empty? || @address_reg.city.empty? || @address_reg.street.empty?
        redirect_to new_order_url, flash: {notice: '配送先の保存に失敗しました。住所の入力は「丁番地」まで必須です。お手数ですがもう一度お願いします。'}
      
      else
      #アドレスの保存に成功していたら↓↓
      
        or_prefecture = Prefecture.find_by(name: @address_reg.prefecture_name)
        
        if payment_type == "クレジットカード他"
          postage = 450
        elsif  payment_type == "代金引換"
          if or_prefecture.id == 1
            postage = 1400
          elsif or_prefecture.id == 2 || or_prefecture.id == 3 || or_prefecture.id == 5
            postage = 1000
          elsif or_prefecture.id == 4 || or_prefecture.id == 6 || or_prefecture.id == 7
            postage = 900      
          elsif or_prefecture.id >= 8 && or_prefecture.id <= 15
            postage = 800
          elsif or_prefecture.id == 19 || or_prefecture.id == 20
            postage = 800
          elsif or_prefecture.id == 16 || or_prefecture.id == 17 || or_prefecture.id == 18
            postage = 700   
          elsif or_prefecture.id >= 19 && or_prefecture.id <= 35
            postage = 700
          elsif or_prefecture.id >= 36 && or_prefecture.id <= 46
            postage = 800
          elsif or_prefecture.id == 47
            postage = 1200
          end
        end
        
        if amount >= 1800 && amount < 3600 
          postage = postage / 2
        elsif amount >= 3600
          postage = 0    
        end
        
        add_amount = amount + pay_commission + postage
        tax = (add_amount * 0.08).floor
        total_amount = add_amount + tax
      
        begin
          ActiveRecord::Base.transaction do
            @order_reg = Order.create!(user_id:@user_id, address_id:@address_reg.id, payment_type:payment_type, shipping_type:shipping_type, amount:amount, pay_commission:pay_commission, postage:postage, add_amount:add_amount, tax:tax, total_amount:total_amount)
            raise "例外発生"
          
            line_items.each do |li| 
              Orderdetail.create!(product_id:li.product_id, order_id:@order_reg.id, product_type:li.product_type, count:li.count) 
            end
          
            cart.destroy
            session[:cart_id] = nil
            NoticeMailer.send_when_order(@order_reg).deliver
          end
            session[:forwarding_url] = nil
            redirect_to @order_reg
          rescue => e
          redirect_to new_order_url, flash: {notice: '処理に失敗しました。お手数ですがもう一度お願いします。'}
        end
      end
      
    else
    #ログインしていない場合↓↓
    @user_id = nil
      address = params[:address]
      addressee = address['addressee']
      order_email = address['order_email']
      zipcode = address['zipcode']
      prefecture_name = address['prefecture_name']
      city = address['city']
      street = address['street']
      building = address['building']
      @address_reg = Address.new(user_id:nil, addressee:addressee, order_email:order_email, zipcode:zipcode, prefecture_name:prefecture_name, city:city, street:street, building:building)
      
      unless @address_reg.save
        redirect_to new_order_url, flash: {notice: '配送先の保存に失敗しました。住所の入力は「丁番地」まで必須です。お手数ですがもう一度お願いします。'}
      
      else 
      #アドレスの保存に成功していたら↓↓
        or_prefecture = Prefecture.find_by(name: @address_reg.prefecture_name)
        
        if payment_type == "クレジットカード他"
          postage = 450
        elsif  payment_type == "代金引換"
          if or_prefecture.id == 1
            postage = 1400
          elsif or_prefecture.id == 2 || or_prefecture.id == 3 || or_prefecture.id == 5
            postage = 1000
          elsif or_prefecture.id == 4 || or_prefecture.id == 6 || or_prefecture.id == 7
            postage = 900      
          elsif or_prefecture.id >= 8 && or_prefecture.id <= 15
            postage = 800
          elsif or_prefecture.id == 19 || or_prefecture.id == 20
            postage = 800
          elsif or_prefecture.id == 16 || or_prefecture.id == 17 || or_prefecture.id == 18
            postage = 700   
          elsif or_prefecture.id >= 19 && or_prefecture.id <= 35
            postage = 700
          elsif or_prefecture.id >= 36 && or_prefecture.id <= 46
            postage = 800
          elsif or_prefecture.id == 47
            postage = 1200
          end
        end
        
        if amount >= 1800 && amount < 3600 
          postage = postage / 2
        elsif amount >= 3600
          postage = 0    
        end
        
        add_amount = amount + pay_commission + postage
        tax = (add_amount * 0.08).floor
        total_amount = add_amount + tax
        
        begin
          ActiveRecord::Base.transaction do
            @order_reg = Order.create!(user_id:@user_id, address_id:@address_reg.id, payment_type:payment_type, shipping_type:shipping_type, amount:amount, pay_commission:pay_commission, postage:postage, add_amount:add_amount, tax:tax, total_amount:total_amount)
            #raise "例外発生"
            
            line_items.each do |li| 
              Orderdetail.create!(product_id:li.product_id, order_id:@order_reg.id, product_type:li.product_type, count:li.count) 
            end
            
            cart.destroy
            session[:cart_id] = nil
            NoticeMailer.send_when_order(@order_reg).deliver
          end
            session[:forwarding_url] = nil
            redirect_to @order_reg
          rescue => e
          redirect_to new_order_url, flash: {notice: '処理に失敗しました。お手数ですがもう一度お願いします。'}
        end  
      end
      
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
  
  def logged_in_order_user
    @order = Order.find(params[:id])
    unless logged_in?
      store_location
      redirect_to login_url, flash: {notice: '注文詳細の確認にはログインが必要です'}
    else
      if current_user.id == @order.user_id
        return true
      else
        store_location
        redirect_to login_url, flash: {notice: '他ユーザーの注文詳細はご覧になれません'}
      end
    end
  end

end