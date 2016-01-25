require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(name: "User", email: "user@user.com", password: "foobar", password_confirmation: "foobar"))
  end

  it "renders attributes in <p>" do
    render
  end
end
