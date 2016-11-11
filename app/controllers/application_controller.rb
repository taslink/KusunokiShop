class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :ensure_domain
  
  include SessionsHelper
  
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end
  
  include ErrorHandlers if Rails.env.production?

  private
  
  # redirect correct server from herokuapp domain for SEO
  #def ensure_domain
    #return unless /\.herokuapp.com/ =~ request.host
    
    # 主にlocalテスト用の対策80と443以外でアクセスされた場合ポート番号をURLに含める 
    #port = ":#{request.port}" unless [80, 443].include?(request.port)
    #redirect_to "#{request.protocol}#{FQDN}#{port}#{request.path}", status: :moved_permanently
  #end
  
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