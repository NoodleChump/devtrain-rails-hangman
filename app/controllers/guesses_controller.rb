class GuessesController < ApplicationController
  def create
    @guess = Guess.new(guess_params)
    @game = @guess.game
    if @guess.save
      redirect_to @guess.game
    else
      render 'games/show'
    end
  end

  private

  def guess_params
    # TODO require
    params[:guess].permit(:letter, :game_id)
  end
end
