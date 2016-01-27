class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :logged_in, only: [:index, :show, :new, :custom]

  helper_method :sort_column

  def index
    @games = GamesPresenter.apply_sort(Game.all, sort_column, sort_direction).paginate(page: params[:page], per_page: 10)
  end

  def show
    @guess = Guess.new
    @game = Game.find(params[:id])
  end

  def new
    word = GenerateRandomWord.new.call
    @game = Game.new(number_of_lives: Game::DEFAULT_NUMBER_OF_LIVES, user: current_user)
    @game.save!
    redirect_to @game
  end

  def custom
    @game = Game.new(custom: true)
    @custom_word = @game.custom_word
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

  def destroy
    @game.destroy
    flash[:success] = "Game deleted successfully"
    redirect_to games_url
  end

  private

  def sort_column
    params[:sort] || "name"
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:word_to_guess, :number_of_lives, :user_id)
  end

  def logged_in
    if !logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
