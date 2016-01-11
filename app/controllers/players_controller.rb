class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
    apply_sort
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

  def sort_column
    params[:sort] ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def player_params
    params[:player].permit(:name)
  end

  def apply_sort
    case sort_column
    when "name"
      @players = @players.sort_by { |player| player.name }
    when "rank"
      @players = @players.sort_by { |player| player.ranking }
    when "won"
      @players = @players.sort_by { |player| player.won_games.count }
    when "lost"
      @players = @players.sort_by { |player| player.lost_games.count }
    else
      @players = @players.sort_by { |player| player.name }
    end

    if sort_direction == "desc"
      @players.reverse!
    end
  end
end
