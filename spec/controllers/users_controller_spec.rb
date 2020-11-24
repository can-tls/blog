require "rails_helper"
RSpec.describe UsersController, :type => :controller do
  include RSpec::Rails::ControllerExampleGroup
  describe "responds to" do
    it "responds to html by default" do
      post :create, params: { user: { name: "Can Talas" } }
      expect(response.status).to eq(200)
    end
  end

  describe "responds to" do
    it "expects to be not 500" do
      post :create, params: { user: { name: "Can Talas" } }
      expect(response.status).not_to eq(500)
    end
  end

  it "expects not save user and flash danger" do
    post :create, params: { user: { name: "Can Talas", password: "" } }
    expect(flash[:danger]).to be_present
  end
  
  it "expects to redirect after login" do
    user1 = create(:user)
    post :create, params: user1
    expect(subject).to redirect_to '/login'
  end

  # it "expect to verify user with flash" do
  #   User.create
  #   patch :update, params: { user: { name: "new Can Talas", email: "new-eliminator-44@hotmail.de", password: "new-hallo123"} }
  #   expect(flash[:success]).to be_present
  # end
end