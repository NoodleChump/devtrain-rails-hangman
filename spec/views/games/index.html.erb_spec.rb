require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    log_in create(:user)

    assign(:games, create_list(:game, 30).paginate)
  end

  it "renders a list of games" do
    render
  end
end
