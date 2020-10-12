class LoginController < ApplicationController
  
  def new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.find_by(email: params[:login][:email].downcase)
    if @user.password == params[:login][:password]
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
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