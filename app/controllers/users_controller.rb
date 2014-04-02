class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :remove_password, only: :update
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_filter :authorize!, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(allowed_user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @user.update(allowed_user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def authorize!
    authorize_access!(current_user.admin? || current_user == @user)
  end

  def set_user
    if params[:id]
      @user = User.find(params[:id])
    elsif user_signed_in?
      @user = User.find(current_user.id)
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def remove_password
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end
  end

  def resource
    @user
  end
  helper_method :resource
end
