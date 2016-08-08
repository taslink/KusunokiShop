module SessionsHelper
    
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  #リクエストがGETの場合は、session[:forwarding_url]にリクエストのURLを代入
  #ログインが必要なページにアクセスしようとした際に、ページのURLを一旦保存、
  #ログイン画面に遷移してログイン後に再びアクセスする場合にこのメソッドを使用
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
