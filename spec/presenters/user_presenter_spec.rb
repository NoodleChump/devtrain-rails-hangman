require 'rails_helper'

RSpec.describe UserPresenter, type: :presenter do
  include ActionView::TestCase::Behavior

  let(:user) { create(:user) }

  subject(:presented_user) { UserPresenter.new(user) }

  describe User, '#gravatar' do
    it "has a gravatar image tag generated from the user email" do
      expect(presented_user.gravatar).to include("<img", user.name, "gravatar.com/avatar/")
    end

    it "has a smaller resized gravatar when a small size is given" do
      expect(presented_user.gravatar(size: :small)).to include("<img", user.name, "gravatar.com/avatar/", "?s=32")
    end

    it "has a medium resized gravatar when a medium size is given" do
      expect(presented_user.gravatar(size: :medium)).to include("<img", user.name, "gravatar.com/avatar/", "?s=64")
    end

    it "has an original (not resized) gravatar when a full size is given" do
      expect(presented_user.gravatar(size: :full)).to include("<img", user.name, "gravatar.com/avatar/")
      expect(presented_user.gravatar(size: :full)).to_not include("?s=")
    end
  end

end
