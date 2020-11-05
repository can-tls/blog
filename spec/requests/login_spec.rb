require 'rails_helper'
require 'login_controller'
require 'user'
RSpec.describe LoginController do
  # it "success" do
  #   mock_user = {email: "eliminator-44@hotmail.de", password: "hallo123"}
  #   user_params = {email: "eliminator-44@hotmail.de", password: "hallo123"}
  #   response = expect(mock_user[:email]).to eq user_params[:email]
  # end

  # it "fail" do
  # expect(flash[:warning]).to be_present
  # end

  # it "render Settings" do
  #   mock_user = {email: "eliminator-44@hotmail.de", password: "hallo123", id: 100000}
  #   sign_in mock_user
  #   expect(response).to render_template("users/:id/edit")
  # end

  it "should login user" do

    class User
      def initialize(user)
        @user = user
      end
    end

    user1 = double('user')
    allow(user1).to receive(:email) { 'eliminator-44@hotmail.de' }
    allow(user1).to receive(:password) { 'hallo123' }
    allow(user1).to receive(:id) { 1000 }

    lg = LoginController.new
    expect(lg.create(@user)).to be true
  end
end