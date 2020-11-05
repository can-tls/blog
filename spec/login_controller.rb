class LoginController
  def create(user)
    # @user = User.find_by(email: params[:login][:email].downcase)
    if @user.password == "hallo123"#params[:login][:password]
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
end