class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end
  
  include ErrorHandlers if Rails.env.production?

  private
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_url, flash: {notice: 'ご利用には会員登録が必要です'}
    end
  end
  
  def logged_in_admin_user
    unless admin_user?
      store_location
      redirect_to login_url, flash: {notice: '管理者としてログインしてください'}
    end
  end
  
  def current_cart
    # sessionはハッシュのようにアクセスできる
    begin
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      # 新しいカートを作成する(DBも書き込む)
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end

end