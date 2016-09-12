class UsersController < ApplicationController
  before_action :correct_user, only: [:show, :update, :destroy]
  before_action :logged_in_admin_user, only: [:index]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(current_user.id)
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end
  
  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to edit_user_url, notice: '内容を変更しました'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :postalcode, :address)
  end
  
end
