require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(name: "User 1"),
      User.create!(name: "User 2")
    ])
  end

  it "renders a list of users" do
    render
  end
end
