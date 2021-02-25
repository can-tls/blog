class LoginController < ApplicationController
  
  def new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.find_by(email: params[:login][:email].downcase)
    if @user.present?
      if @user.password == params[:login][:password]
        log_in @user
        redirect_to @user
      else
        flash.now[:danger] = t('.invalid')
        render 'new'
      end
    else
      flash.now[:danger] = t('.information')
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
  private 

    def login_params
      params.require(:login).permit(:email, :password, :remember_me)
    end
end