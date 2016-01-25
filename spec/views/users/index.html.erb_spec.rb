require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(name: "User 1", email: "1@user.com"),
      User.create!(name: "User 2", email: "2@user.com")
    ])
  end

  it "renders a list of users" do
    render
  end
end
