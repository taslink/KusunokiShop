class WelcomeController < ApplicationController
  def index
    #Productモデルからtypeがenvelopeのすべてのレコードを取得
    @product_envelopes = Product.where(product_type: 'envelope')
    #Productモデルからtypeがcardのすべてのレコードを取得
    #@product_cards = Product.where(product_type: 'card')
  end
end