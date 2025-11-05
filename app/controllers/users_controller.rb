class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update invite profile ]
  after_action :verify_authorized

  def index
    user = Current.user
    if user.admin?
      @users = User.includes(:roles).all
    else
      @users = User.includes(:roles).where(id: user.id)
    end
    authorize @users
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def invite
    authorize @user

    respond_to do |format|
      if @user.active?
        PasswordsMailer.welcome(@user).deliver_later
        format.html { redirect_to @user, notice: "User was successfully invited." }
      else
        format.html { redirect_to @user, alert: "User is not active, cannot send invite." }
      end
    end
  end

  def profile
    authorize @user
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :active, role_ids: [], site_ids: [])
    end
end
