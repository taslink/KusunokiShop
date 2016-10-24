class NoticeMailer < ApplicationMailer
    
  def send_when_signin(user)
    @user = user
    mail to: user.email,
         subject: 'ユーザー登録ありがとうございます'
  end
  
  def send_when_order(order)
    @order = order
    @user = @order.user
    mail to: @user.email,
         subject: 'ご注文ありがとうございます'
  end
  
  def received_inquiry(inquiry)
    @inquiry = inquiry
        mail to: "kusu.ikuyorihato@gmail.com",
         subject: 'WEB SHOP からの問い合わせ'
  end
  
end