require "rails_helper"
require "login_helper"

RSpec.describe MicropostsController, :type => :controller do   
  include RSpec::Rails::ControllerExampleGroup
  describe do
    before do
      allow(controller).to receive(:current_user) { user }
    end

    let(:user) {User.new(name: "Can Talas", email: "eliminator-44@hotmail.de", id: 1)}

    it "should exec @micropost = current_user.microposts.build(micropost_params)" do
      post :create, params: {micropost: { titel: "titel", content: "content", user_id: 1 }}
      expect(flash[:success]).to be_present
      assert_response :redirect
    end

    it "should exec @micropost = current_user.microposts.build(micropost_params)" do
      post :create, params: {micropost: { titel: "", content: "", user_id: "1" }}
      expect(flash[:success]).not_to be_present
      expect(response.status).to eq(200)
      assert_response :success
    end

    it "new action should succeed" do
      get :new
      assert_response :success
    end

    it "new action should succeed" do
      get :index
      assert_response :success
    end

    # it "update post" do
    #   get :update, params: {micropost: { titel: "", content: "", user_id: "1" }}
    #   expect(flash[:danger]).to eq("Post updated")
    # end
    describe do
      let (:micropost) { FactoryBot.build(:micropost) }
      it "should redirect after destroy" do
        delete :destroy, params: @micropost
        expect(subject).to redirect_to '/all'
      end
    end
  end
end