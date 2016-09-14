class OrderdetailsController < ApplicationController
  before_action :logged_in_admin_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_orderdetail, only: [:show]
  
  # GET /orderdetails
  def index
    @orderdetails = Orderdetail.all
  end

  # GET /orderdetails/1
  def show
  end

  # GET /orderdetails/new
  def new
    @orderdetail = Orderdetail.new
  end
  
  # POST /orderdetails
  def create
    @orderdetail = Orderdetail.new(orderdetail_path)
    if @orderdetail.save
      redirect_to @orderdetail, notice: 'Orderdetail was successfully created.'
    else
      render :new
    end
  end
  
  private
  
  def set_orderdetail
    @orderdetail = Orderdetail.find(params[:id])
  end

end
