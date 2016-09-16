class AddressesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  
  # coding: utf-8
  
  include SessionsHelper

  # GET /addresses
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
    @redirect_option = params[:redirect_option]
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    if @address.save
      if logged_in?
        redirect_to edit_user_url(current_user), notice: '配送先情報を登録しました'
      else
        redirect_to root_path, notice: '配送先情報を登録しました'
      end
    else
      render :new
    end
  end

  # PATCH/PUT /addresses/1
  def update
    
    redirect_option = params[:redirect_option]
    
    if @address.update(address_params)
      if logged_in? && redirect_option.empty?
        redirect_to edit_user_url(current_user), notice: '配送先情報を変更しました'
      elsif logged_in? && redirect_option == "order_new"
        redirect_to new_order_url, notice: '配送先情報を変更しました'
      else
        redirect_to root_path, notice: '配送先情報を変更しました'
      end
    else
      render :edit        
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
      redirect_to addresses_url, notice: 'Address was successfully destroyed.' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:user_id, :addressee, :prefecture_name, :zipcode, :city, :street, :building)
    end
end
