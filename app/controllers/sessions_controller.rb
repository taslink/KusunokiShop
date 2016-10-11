class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to :root
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end

  def info_update
    @s_payment = session[:payment]
    @s_prefecture = session[:prefecture]
    ridirect_to cart/index
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
