class NoticeMailer < ApplicationMailer
    
  def send_when_signin(user)
    @user = user
    mail to: user.email,
         subject: 'ユーザー登録ありがとうございます'
  end
  
  def send_when_order(order)
    @order = order
    
    if @order.user_id.nil?
      @user_name = @order.address.addressee
    else
      @user_name = @order.user.name
    end
    
    mail to: @order.address.order_email,
         subject: 'ご注文ありがとうございます'

  end
  
  def received_inquiry(inquiry)
    @inquiry = inquiry
        mail to: @inquiry.email,
         subject: 'お問い合わせを受け付けました'
  end
  
end