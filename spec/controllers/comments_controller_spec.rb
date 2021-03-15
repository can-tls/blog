require "rails_helper"
RSpec.describe CommentsController, :type => :controller do
  include RSpec::Rails::ControllerExampleGroup
  it "responds to html by default" do
    MICROPOST
    post :create, params: { comment: { name: "Can Talas", body: "ich mag es Sachen zu kommentieren" } }
    expect(response.status).to eq(200)
  end
end