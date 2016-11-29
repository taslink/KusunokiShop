class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_admin_user, except: :show
  before_action :store_location, only: [:show]

  # GET /products
  def index
    @products = Product.all.order(sort_no: :asc)
  end

  # GET /products/1
  def show
    #Productモデルからtypeがenvelopeのすべてのレコードを取得
    #@product_envelopes = Product.where(product_type: 'envelope').order(product_code: :asc)
    #Productモデルからtypeがcardのすべてのレコードを取得
    @product_cards = Product.where(product_type: 'card').order(sort_no: :asc)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_url, notice: 'Product was successfully created.' 
    else
      render :new
    end
  end
  
  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to products_url, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    if @product.destroy
      redirect_to products_url, notice: 'Product was successfully destroyed.'
    else
      redirect_to products_url, notice: '消せないよ～！'
    end
  end

  private
    def set_product
     @product = Product.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
   def product_params
     params.require(:product).permit(:product_code, :name, :price, :description, :product_type,
     :main_image, :main_image_cache, :remove_main_image,
     :sub1_image, :sub1_image_cache, :remove_sub1_image,
     :sub2_image, :sub2_image_cache, :remove_sub2_image)
   end
end