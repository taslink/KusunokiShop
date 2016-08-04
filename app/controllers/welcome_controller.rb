class WelcomeController < ApplicationController
  def index
    #Productモデルからtypeがenvelopeのすべてのレコードを取得
    @products = Product.where(product_type: 'envelope')
  end
end