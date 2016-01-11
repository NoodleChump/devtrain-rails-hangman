class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :submit_guess] #TODO Move into guess controller (nesting)
  helper_method :sort_column, :sort_direction

  def index
    @games = Game.all
    apply_sort
  end

  def show
    @guess = Guess.new
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      flash[:success] = "Game created successfully"
      redirect_to @game
    else
      render 'new'
    end
  end

  def update
    if @game.update(game_params)
      flash[:success] = "Game updated successfully"
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    @game.destroy
    flash[:success] = "Game deleted successfully"
    redirect_to games_url
  end

  def submit_guess
    @guess = Guess.new(guess_params)
    if @guess.save
      redirect_to @game
    else
      render 'show'
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def sort_column
    params[:sort] ? params[:sort] : "player_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def game_params
    params[:game].permit(:word_to_guess, :number_of_lives, :player_id)
  end

  def guess_params
    params[:guess].permit(:letter, :game_id)
  end

  def apply_sort # This is presenter logic #TODO Make and move it
    case sort_column
    when "player_name"
      @games = @games.sort_by { |game| game.player.name }
    when "progress"
      @games = @games.sort_by { |game| game.progress }
    when "remaining_guesses"
      @games = @games.sort_by { |game| game.number_of_guesses_remaining }
    else
      @games = @games.sort_by { |game| game.player.name }
    end

    if sort_direction == "desc"
      @games.reverse!
    end
  end
end
