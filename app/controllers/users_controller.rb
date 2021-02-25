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
      flash[:success] = t(".welcome")
      redirect_to '/login'
    else
      flash.now[:danger] = t(".fields")
      render 'new'
    end
  end

  def forgot_password
    @user = User.find_by_email(params[:user][:email].downcase)
    if @user.present?
      UserMailer.with(user: @user).forgot_password_email.deliver_now
      flash[:success] = t(".check")
      redirect_to '/login'
    else
      redirect_to users_send_email_path
      flash[:danger] = t(".exist")
    end
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
    @sadmin = User.find_by_email("talascan@googlemail.com")
    if current_user == @user || current_user == @sadmin
      @user.update_attributes(user_params)
      flash[:success] = t(".updated")
      redirect_to @user
    elsif @user.defaultpw_valid?(params[:user][:defaultpw])
      @user.update_attributes(user_params)
      flash[:success] = t(".welcome")
      log_in @user
      redirect_to @user
    else
      flash[:danger] = t(".wrong")
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :defaultpw, :avatar, :avatar_url, :role, :locale)
    end

    def logged_in_user
        unless logged_in?
          flash[:danger] = t(".please")
          redirect_to login_url
        end
    end
end