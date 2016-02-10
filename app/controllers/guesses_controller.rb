class GuessesController < ApplicationController
  before_action :find_game
  before_action :authenticated

  def index
    @guesses = Guess.where("game_id = ?", params[:game_id])
    render nothing: true
  end

  def create
    @guess = MakeGuess.new(@game, guess_params[:letter]).call
    if @guess.errors.blank?
      redirect_to @game

      CompletedGameNotification.create!(
        sender:   @game.user,
        receiver: @game.sender,
        game_id:  @game.id
      ) if @game.sender && @game.game_over? && @game.sender != @game.user
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
