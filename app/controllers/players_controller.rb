class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:success] = "Player created successfully"
      redirect_to @player
    else
      render 'new'
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    if @player.update(player_params)
      flash[:success] = "Player updated successfully"
      redirect_to @player
    else
      render 'edit'
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    flash[:success] = "Player deleted successfully"
    redirect_to players_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def player_params
    params[:player].permit(:name)
  end
end
