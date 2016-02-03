require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    log_in create(:user)

    assign(:users, [
      create(:named_user, name: "Bob"),
      create(:named_user, name: "John")
    ].paginate)
  end

  it "renders a list of users" do
    render
  end
end
