class Inquiry
  include ActiveModel::Model #ここでActiveModelを読み込んで、DBと繋がらないモデルとしている

  attr_accessor :name, :email, :message #これ大事

  validates :name, :presence => {:message => '名前を入力してください'}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: 'メールアドレスを入力してください'}, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX, message: '正しいアドレス形式ではありません' }
  validates :message, :presence => {:message => 'お問い合わせ内容を記載してください'}
end