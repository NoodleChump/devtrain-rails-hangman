class HangmanGamesController < ApplicationController
  before_action :set_hangman_game, only: [:show, :edit, :update, :destroy]

  # GET /hangman_games
  # GET /hangman_games.json
  def index
    @hangman_games = HangmanState.all
  end

  # GET /hangman_games/1
  # GET /hangman_games/1.json
  def show
  end

  # GET /hangman_games/new
  def new
    @hangman_game = HangmanState.new
  end

  # GET /hangman_games/1/edit
  def edit
  end

  # POST /hangman_games
  # POST /hangman_games.json
  def create
    @hangman_game = HangmanState.new(hangman_game_params)

    respond_to do |format|
      if @hangman_game.save
        format.html { redirect_to @hangman_game, notice: 'Hangman was successfully created.' }
        format.json { render :show, status: :created, location: @hangman_game }
      else
        format.html { render :new }
        format.json { render json: @hangman_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hangman_games/1
  # PATCH/PUT /hangman_games/1.json
  def update
    respond_to do |format|
      if @hangman_game.update(hangman_game_params)
        format.html { redirect_to @hangman_game, notice: 'Hangman was successfully updated.' }
        format.json { render :show, status: :ok, location: @hangman_game }
      else
        format.html { render :edit }
        format.json { render json: @hangman_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hangman_games/1
  # DELETE /hangman_games/1.json
  def destroy
    @hangman_game.destroy
    respond_to do |format|
      format.html { redirect_to hangman_games_url, notice: 'Hangman was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hangman_game
      @hangman_game = HangmanGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hangman_game_params
      params[:hangman_game]
    end
end
