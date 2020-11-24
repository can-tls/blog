require "rails_helper"
RSpec.describe TagsController, :type => :controller do
  include RSpec::Rails::ControllerExampleGroup
  it "responds to html by default" do
    post :create, params: { comment: { name: "Can Talas", body: "ich mag es Sachen zu kommentieren" } }
    expect(response.status).to eq(200)
  end
end