class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        @microposts = @user.microposts.paginate(page: params[:page])
    end

    def new
        @user = User.new
    end

    def index
      @users = User.paginate(page: params[:page])
    end

    def create
        @user = User.new(user_params)
        if @user.save
          log_in @user
          flash[:success] = "Welcome to the Sample App!"
          redirect_to @user
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
    
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          flash[:success] = "Profile updated"
          redirect_to @user
          # Handle a successful update.
        else
          render 'edit' 
        end
      end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation) #confirmation entfernt
    end

    def logged_in_user
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
    
end

