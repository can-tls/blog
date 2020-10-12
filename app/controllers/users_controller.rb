class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
    
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render 'index'
  end
    
  def edit
    @user = User.find(params[:id])
  end

  def verification
    @user = User.find(params[:id])
    if @user.defaultpw == params[:defaultpw] && @user.password == nil
      @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Welcome! you successfully verified your account"
      redirect_to @user
    elsif @user.defaultpw != params[:user][:defaultpw]
      binding.pry
      flash[:danger] = "wrong defaultpw"
      render 'verification'
    else
      flash[:danger] = "you already verified your account"
      render 'about'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "updated profile"
      redirect_to @user
    else
      render 'edit'
    end
  end
  # def update
  #   @user = User.find(params[:id])
  #   if @user.avatar_url != params[:user][:avatar_url]
  #     @user.update_attributes(user_params)
  #     render 'show'
  #   elsif @user.defaultpw == params[:user][:defaultpw] && @user.password != nil
  #     @user.update_attributes(user_params)
  #     log_in @user
  #     flash[:success] = "Welcome! you successfully verified your account"
  #     redirect_to @user
  #   elsif @user.defaultpw != params[:user][:defaultpw]
  #     flash[:danger] = "wrong defaultpw"
  #     render 'verification'
  #   else
  #     render 'about' 
  #   end
  # end

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