class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_in
  before_action :check_admin_user, only: [:destroy]

  helper_method :sort_column

  def index
    @games = GetSortedGames.new(sort_column, sort_direction).call.paginate(page: params[:page], per_page: 10)
  end

  def show
    @guess = Guess.new
    @game = Game.find(params[:id])
  end

  def new
    @game = MakeGame.new(user: current_user).call
    @game.save!
    redirect_to @game
  end

  def custom
    @game = Game.new(custom: true)
  end

  def create
    @game = MakeGame.new(
        user:             User.find(game_params[:user_id]),
        word_to_guess:    game_params[:word_to_guess],
        number_of_lives:  game_params[:number_of_lives],
        ranked:           !game_params[:custom]
        ).call

    if @game.save
      flash[:success] = "Game created successfully"
      redirect_to @game
    else
      render 'new'
    end
  end

  def destroy
    @game.destroy
    flash[:success] = "Game deleted successfully"
    redirect_to games_url
  end

  private

  def sort_column
    params[:sort] || "date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:word_to_guess, :number_of_lives, :user_id, :custom, :custom_word)
  end
end
