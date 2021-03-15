class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def forgot_password_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Password reset')
  end
end