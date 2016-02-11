class GamesController < ApplicationController
  before_action :set_game,          only: [:show, :edit, :update, :destroy]
  before_action :authenticated,     except: [:index, :show]
  before_action :admin_privileged,  only: [:destroy]

  helper_method :sort_column

  def index
    @games = GetSortedGames.new(sort_column, sort_direction).call.paginate(page: params[:page], per_page: 10)
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = MakeGame.new(user: current_user).call
    redirect_to @game
  end

  def custom
    @user = params[:user]
    @game = Game.new(custom: true)
  end

  def create
    @game = MakeGame.new(
      user:                     User.find(game_params[:user_id]),
      word_to_guess:            game_params[:word_to_guess],
      initial_number_of_lives:  game_params[:initial_number_of_lives],
      ranked:                   !game_params[:custom],
      sender:                   current_user
    ).call

    if @game.save
      
      flash[:success] = "Game created successfully"
      redirect_to @game

      MakeNewGameNotification.new(
        from: current_user,
        to:   @game.user,
        game: @game
      ).call if @game.user != current_user
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
    params.require(:game).permit(:word_to_guess, :initial_number_of_lives, :user_id, :custom, :custom_word)
  end
end
