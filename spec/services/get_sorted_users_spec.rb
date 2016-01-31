require 'rails_helper'

RSpec.describe GetSortedUsers, type: :service do
  let(:user) { User.create!(name: "User", email: "user@user.com", password: "foobar", password_confirmation: "foobar") }
  let(:other_user) { User.create!(name: "Other User", email: "another@user.com", password: "foobar", password_confirmation: "foobar") }
  let(:ai_user) { User.create!(name: "AI User", email: "yet.another@user.com", password: "foobar", password_confirmation: "foobar") }

  let(:boring_word) { "word" }
  let(:a_word) { "a" }
  let(:other_word) { "other" }

  let(:boring_game) { Game.create!(word_to_guess: boring_word, number_of_lives: 5, user: user) }
  let(:a_game) { Game.create!(word_to_guess: a_word, number_of_lives: 3, user: ai_user) }
  let(:other_game) { Game.create!(word_to_guess: other_word, number_of_lives: 1, user: other_user) }

  let(:users) { [user, ai_user, other_user] }
  let(:games) { [boring_game, a_word, other_game] }

  describe "#apply_sort" do
    before do
      HangmanSpecHelper::make_guess(other_game, "z") # lost
      HangmanSpecHelper::make_guesses(boring_game, "wzr") # in progress
      HangmanSpecHelper::make_guesses(a_game, "a") # won

      users.each(&:update_rank_weight)
    end

    context "when sorting by name" do
      it "sorts (ascending) correctly" do
        sorted_users = GetSortedUsers.new('name', 'asc').call
        expect(sorted_users).to eq [ai_user, other_user, user]
      end

      it "sorts (descending) correctly" do
        sorted_users = GetSortedUsers.new('name', 'desc').call
        expect(sorted_users).to eq [user, other_user, ai_user]
      end
    end

    context "when sorting by ranking" do
      it "sorts (ascending) correctly" do
        sorted_users = GetSortedUsers.new('ranking', 'asc').call
        0...sorted_users.count do |user|
          expect(sorted_users[user].rank_points <= sorted_users[user + 1].rank_points).to be true
        end
      end

      it "sorts (descending) correctly" do
        sorted_users = GetSortedUsers.new('ranking', 'desc').call
        0...sorted_users.count do |user|
          expect(sorted_users[user].rank_points >= sorted_users[user + 1].rank_points).to be true
        end
      end
    end
  end
end
