class GamePresenter < BasePresenter
  CENSOR_CHARACTER = "*"

  presents :game

  def censored_word
    game.censored_word.map { |item| item != nil ? item : CENSOR_CHARACTER }.join
  end

  def number_of_blanks_remaining
    game.censored_word.count(nil)
  end

  def progression_percentage #TODO float/decimal NOT percentage
    game.lost? ? 100.0 : (number_of_incorrect_guesses / game.number_of_lives.to_f) * 100
  end

  def progression
    if game.won?
      :won
    elsif game.lost?
      :lost
    elsif game.guesses.present?
      :in_progress
    else
      :not_started
    end
  end

  def hangman_image
    h.image_tag("hang#{ (progression_percentage / 10).to_i }.gif", class: "hangman-image")
  end

  private

  def number_of_incorrect_guesses
    game.incorrect_guesses.length
  end
end
