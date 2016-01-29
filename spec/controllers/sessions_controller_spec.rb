require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:valid_user) { User.create!(name: "user", email: "user@example.com", password: "password", password_confirmation: "password") }

  let(:valid_login) { { email: "invalid.user@example.com", password: "password", remember_me: '0' } }
  let(:invalid_login) { { email: "invalid.user@example.com", password: "invalid", remember_me: '0' } }

  let(:valid_session) { {} }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "when credentials are correct" do
      it "logs the user in" do
        post :create, {session: valid_login}, valid_session
        expect(current_user?(valid_user))
      end
    end

    context "when credentials are incorrect" do
      it "re-renders the login page" do
        post :create, {session: invalid_login}, valid_session
        expect(response).to render_template('new')
      end

      it "has nobody logged in" do
        post :create, {session: invalid_login}, valid_session
        expect(logged_in?).to be false
      end
    end
  end

  describe "DELETE #destroy" do
    context "when a user is logged in" do
      before do
        log_in valid_user
      end

      it "logs the user out" do
        delete :destroy, {}, valid_session
        expect(logged_in?).to be false
      end
    end
  end
end
