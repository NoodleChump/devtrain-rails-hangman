class GuessesController < ApplicationController
  before_action :find_game
  before_action :authenticated

  def create
    @guess = MakeGuess.new(@game, guess_params[:letter]).call
    if @guess.errors.blank?
      redirect_to @game
    else
      render 'games/show'
    end
  end

  def update
    create
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def guess_params
    params.require(:guess).permit(:letter, :game_id)
  end
end
