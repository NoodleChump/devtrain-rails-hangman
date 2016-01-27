require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    log_in User.create!(name: "Admin", email: "user@user.com", password: "foobar", password_confirmation: "foobar", admin: true)

    assign(:users, [
      User.create!(name: "User 1", email: "1@user.com", password: "foobar", password_confirmation: "foobar"),
      User.create!(name: "User 2", email: "2@user.com", password: "foobar", password_confirmation: "foobar")
    ].paginate)
  end

  it "renders a list of users" do
    render
  end
end
