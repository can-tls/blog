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
        post :create, params: {micropost: { titel: "titel", content: "content", user_id: "1" }}
        expect(flash[:success]).to be_present
    end
  end
end