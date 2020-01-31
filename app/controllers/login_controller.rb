class LoginController < ApplicationController
  
  def new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.find_by(email: params[:login][:email].downcase)
    # if user && user.authenticate(params[:login][:password])
    if @user.present?
    #   log_in @user
    #   params[:login][:remember_me] == '1' ? remember(@user) : nil #forget(@user)
      redirect_to @user
      
      # Log the user in and redirect to the user's show page.
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  private 

  def login_params
    params.require(:login).permit(:email, :password, :remember_me)
  end
end