require 'rails_helper'

RSpec.describe GetSortedUsers, type: :service do
  let(:gary) { create(:named_user, name: "Gary") }
  let(:john) { create(:named_user, name: "John") }
  let(:bob) { create(:named_user, name: "Bob") }

  let(:boring_word) { "word" }
  let(:a_word) { "a" }
  let(:other_word) { "other" }

  let(:boring_game) { Game.create!(word_to_guess: boring_word, number_of_lives: 5, user: gary) }
  let(:a_game) { Game.create!(word_to_guess: a_word, number_of_lives: 3, user: bob) }
  let(:other_game) { Game.create!(word_to_guess: other_word, number_of_lives: 1, user: john) }

  let(:users) { [gary, bob, john] }
  let(:games) { [boring_game, a_word, other_game] }

  describe "#apply_sort" do
    before do
      HangmanSpecHelper.make_guesses(other_game, "z") # lost
      HangmanSpecHelper.make_guesses(boring_game, "wzr") # in progress
      HangmanSpecHelper.make_guesses(a_game, "a") # won

      users.each(&:update_rank_weight)
    end

    #TODO Finish these tests with other sort fields, and also the same for games

    context "when sorting by name" do
      it "sorts (ascending) correctly" do
        sorted_users = GetSortedUsers.new('name', 'asc').call
        0...sorted_users.length do |user|
          expect(sorted_users[user].name <= sorted_users[user + 1].name).to be true
        end
      end

      it "sorts (descending) correctly" do
        sorted_users = GetSortedUsers.new('name', 'desc').call
        0...sorted_users.length do |user|
          expect(sorted_users[user].name >= sorted_users[user + 1].name).to be true
        end
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
