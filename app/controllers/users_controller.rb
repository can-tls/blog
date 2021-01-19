class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :verification]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  def show
    @microposts = @user.microposts
  end

  def new
      @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    p params
    @user = User.new(user_params)
    @user.defaultpw = SecureRandom.base64(12)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      flash[:success] = "Welcome to the Sample App! Please check your E-Mail to verify your account"
      redirect_to '/login'
    else
      flash.now[:danger] = 'please fill in all required fields'
      render 'new'
    end
  end

  def forgot_password
    @user = User.find_by_email(params[:user][:email].downcase)
    UserMailer.with(user: @user).forgot_password_email.deliver_now
    flash[:success] = "Please check your E-Mail to reset your password"
    redirect_to '/login'
  end

  def send_email
  end

  def destroy
    @user.destroy
    render 'index'
  end
  
  def edit
  end
  
  def update
    p params
    if @user == current_user
      @user.update_attributes(user_params)
      flash[:success] = "hi"
      redirect_to @user
    elsif @user.defaultpw_valid?(params[:user][:defaultpw])
      @user.update_attributes(user_params)
      flash[:success] = "Welcome! you successfully verified your account"
      log_in @user
      redirect_to @user
    else
      flash[:danger] = "wrong defaultpw or you verified already"
      render 'verification'
    end
  end

  private
  
    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end
    
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :defaultpw, :avatar, :avatar_url)
    end

    def logged_in_user
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    end
end