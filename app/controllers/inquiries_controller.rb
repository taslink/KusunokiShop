class InquiriesController < ApplicationController

  def index
    @inquiry = Inquiry.new
    render :action => 'index'
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
  end

  def thanks
    @inquiry = Inquiry.new(inquiry_params)
    NoticeMailer.received_inquiry(@inquiry).deliver
    #flash[:notice] = "お問い合わせいただき、ありがとうございました。"
    render :action => 'thanks'
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end

end