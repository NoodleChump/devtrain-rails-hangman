class GuessesController < ApplicationController
  before_action :find_game

  def create
    @guess = @game.guesses.build(guess_params)
    if MakeGuess.new(@guess).call
      redirect_to @game
    else
      render 'games/show'
    end
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def guess_params
    params.require(:guess).permit(:letter, :game_id)
  end
end
