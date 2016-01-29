require 'rails_helper'

RSpec.describe GuessesController, type: :controller do

  let(:admin) { User.create!(name: "Admin", email: "admin@example.com", password: "foobar", password_confirmation: "foobar", admin: true) }
  let(:user) { User.create!(name: "Jordane", email: "user@user.com", password: "foobar", password_confirmation: "foobar", admin: false) }
  let(:john) { User.create!(name: "John", email: "john@example.com", password: "foobar", password_confirmation: "foobar", admin: false) }

  let(:word) { "word" }
  let(:lives) { 5 }
  let(:game) { Game.create!(word_to_guess: word, number_of_lives: lives, user: user) }

  let(:valid_attributes) {
    { letter: "a", game: game }
  }

  let(:invalid_attributes) {
    { letter: "abc", game: game }
  }

  let(:valid_session) { {} }

  describe "POST #create" do
    context "when logged in as the player of the game of the guess" do
      before do
        log_in user
      end

      context "with valid params" do
        it "creates a new guess" do
          expect {
            post :create, { game_id: game, guess: valid_attributes }, valid_session
          }.to change(Guess, :count).by(1)
        end

        it "assigns a newly created guess as @guess" do
          post :create, { game_id: game, guess: valid_attributes }, valid_session
          expect(assigns(:guess)).to be_a(Guess)
          expect(assigns(:guess)).to be_persisted
        end

        it "redirects to the game of the created guess" do
          post :create, { game_id: game, guess: valid_attributes }, valid_session
          expect(response).to redirect_to(assigns(:guess).game)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved guess as @guess" do
          post :create, { game_id: game, guess: invalid_attributes }, valid_session
          expect(assigns(:guess)).to be_a_new(Guess)
        end

        it "doesn't create a new guess" do
          expect {
            post :create, { game_id: game, guess: invalid_attributes }, valid_session
          }.to change(Guess, :count).by(0)
        end

        it "re-renders the guess' game" do
          post :create, { game_id: game, guess: invalid_attributes }, valid_session
          expect(response).to render_template('games/show')
        end
      end
    end

    context "when logged out" do
      before do
        log_out if logged_in?
      end

      it "redirects to the sign in page" do
        post :create, { game_id: game, guess: valid_attributes }, valid_session
        expect(response).to redirect_to(login_url)
      end
    end
  end
end
