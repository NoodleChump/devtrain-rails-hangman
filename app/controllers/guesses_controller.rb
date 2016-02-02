class GuessesController < ApplicationController
  before_action :find_game
  before_action :logged_in, only: [:create]

  def create
    @guess = @game.guesses.build(guess_params)
    if IsUniqueGuess.new(@guess).call
      redirect_to @game
    else
      @game.guesses.reload
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

  def logged_in
    if !logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
