require 'spec_helper'

feature "User signup", type: :feature, tag: :play do
  include ActionView::Helpers::TextHelper

  let(:user) { create(:user) }

  let(:word) { "word" }
  let(:lives) { 3 }
  let(:game) { create(:game, user: user, word_to_guess: word, initial_number_of_lives: lives) }

  scenario "Aces a game without errors" do
    log_in_as_user
    visit_game_page
    word.chars.each { |letter| fill_and_submit_guess(letter) }
    expect_to_see_game_won
    expect_to_see_guesses_remaining(lives)
  end

  scenario "Wins a game with some errors" do
    log_in_as_user
    visit_game_page
    (('a'..'z').to_a - word.chars).first(lives - 1).each { |letter| fill_and_submit_guess(letter) }
    word.chars.each { |letter| fill_and_submit_guess(letter) }
    expect_to_see_game_won
    expect_to_see_guesses_remaining(1)
  end

  scenario "Loses a game" do
    log_in_as_user
    visit_game_page
    (('a'..'z').to_a - word.chars).first(lives).each { |letter| fill_and_submit_guess(letter) }
    expect_to_see_game_lost
  end

  scenario "Makes invalid guesses" do
    log_in_as_user
    visit_game_page
    fill_and_submit_guess("asdf")
    expect_to_see_letter_error

    fill_and_submit_guess("!")
    expect_to_see_alphabet_error

    2.times { fill_and_submit_guess("a") }
    expect_to_see_already_guessed_error
  end

  private

  def log_in_as_user
    visit login_url
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    find_button("Log In").click
  end

  def visit_game_page
    visit game_path(game)
  end

  def fill_and_submit_guess(letter)
    fill_in 'guess_letter', with: letter
    find_button("Guess!").click
  end

  def expect_to_see_game_won
    expect(page).to have_content "guessed the word correctly"
  end

  def expect_to_see_guesses_remaining(remaining_lives)
    expect(page).to have_content "#{pluralize(remaining_lives, "life")} remaining"
  end

  def expect_to_see_game_lost
    expect(page).to have_content "out of lives"
  end

  def expect_to_see_letter_error
    expect(page).to have_content "error"
    expect(page).to have_content "length"
  end

  def expect_to_see_alphabet_error
    expect(page).to have_content "error"
    expect(page).to have_content "alphabet"
  end

  def expect_to_see_already_guessed_error
    expect(page).to have_content "error"
    expect(page).to have_content "already been guessed"
  end
end
