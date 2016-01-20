require 'rails_helper'

RSpec.describe UsersPresenter, type: :presenter do
  let(:user) { User.create!(name: "User") }
  let(:other_user) { User.create!(name: "Other User") }
  let(:ai_user) { User.create!(name: "AI User") }

  let(:boring_word) { "word" }
  let(:a_word) { "a" }
  let(:other_word) { "other" }

  let(:boring_game) { Game.create!(word_to_guess: boring_word, number_of_lives: 5, user: user) }
  let(:a_game) { Game.create!(word_to_guess: a_word, number_of_lives: 3, user: ai_user) }
  let(:other_game) { Game.create!(word_to_guess: other_word, number_of_lives: 1, user: other_user) }

  let(:users) { [user, ai_user, other_user] }

  describe "#apply_sort" do
    before do
      HangmanSpecHelper::make_guess(other_game, "z") # lost
      HangmanSpecHelper::make_guesses(boring_game, "wzr") # in progress
      HangmanSpecHelper::make_guesses(a_game, "a") # won
    end

    context "when sorting by name" do
      it "sorts (ascending) correctly" do
        sorted_users = UsersPresenter.apply_sort(users, 'name', 'asc')
        expect(sorted_users).to eq [ai_user, other_user, user]
      end

      it "sorts (descending) correctly" do
        sorted_users = UsersPresenter.apply_sort(users, 'name', 'desc')
        expect(sorted_users).to eq [user, other_user, ai_user]
      end
    end

    context "when sorting by ranking" do
      it "sorts (ascending) correctly" do
        sorted_users = UsersPresenter.apply_sort(users, 'ranking', 'asc')
        expect(sorted_users).to eq [ai_user, user, other_user]
      end

      it "sorts (descending) correctly" do
        sorted_users = UsersPresenter.apply_sort(users, 'ranking', 'desc')
        expect(sorted_users).to eq [other_user, user, ai_user]
      end
    end
  end
end
