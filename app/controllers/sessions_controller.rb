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
    redirect_to root_path
  end

end
