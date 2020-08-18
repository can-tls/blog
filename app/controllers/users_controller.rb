class UsersController < ApplicationController

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
      if @user.defaultpw == params[:defaultpw]
        @user.update_attributes(user_params)
        log_in @user
        flash[:success] = "Welcome! you successfully verified your account"
        redirect_to @user
      else
       # flash[:danger] = "the default-password is wrong"
        render 'verification'
      end
    end
    
    def update
        @user = User.find(params[:id])
        if @user.password != nil
          flash[:danger] = "You already updated your password"
          render 'verification'
        elsif @user.defaultpw == params[:user][:defaultpw]
          @user.update_attributes(user_params)
          log_in @user
          flash[:success] = "Welcome! you successfully verified your account"
          redirect_to @user
        elsif @user.defaultpw != params[:user][:defaultpw]
          flash[:danger] = "wrong defaultpw"
          render 'verification'
        else
          render 'about' 
        end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :defaultpw, :avatar)
    end

    def logged_in_user
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    end
  end
