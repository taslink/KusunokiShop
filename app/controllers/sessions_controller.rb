class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      
      if session[:forwarding_url].nil?
        redirect_to root_path
      else
        redirect_to session[:forwarding_url]
      end
      
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:forwarding_url] = nil
    #session[:cart_id] = nil
    redirect_to root_path
  end
  
  def info_update
    cartinfo = params[:cartinfo]
    shipping_prefecture = cartinfo['shipping_prefecture']
    
    if shipping_prefecture == "everyplace"
      session[:payment_type] = "payment02"
      session[:shipping_type] = "nekoposu"
      session[:shipping_prefecture] = shipping_prefecture
    else
      session[:payment_type] = "payment01"
      session[:shipping_type] = "takkyubin"
      session[:shipping_prefecture] = shipping_prefecture
    end
    
    redirect_to carts_path
  end

  def info_destroy
    session[:payment_type] = nil
    session[:shipping_type] = nil
    session[:shipping_prefecture] = nil
    
    redirect_to carts_path
  end

end
