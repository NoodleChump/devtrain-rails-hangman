class PlayersController < ApplicationController
  include PlayersPresenter
  
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column

  def index
    players = Player.all
    @players = apply_sort(players, sort_column, sort_direction)
  end

  def show
  end

  def new
    @player = Player.new
  end

  def edit
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:success] = "Player created successfully"
      redirect_to @player
    else
      render 'new'
    end
  end

  def update
    if @player.update(player_params)
      flash[:success] = "Player updated successfully"
      redirect_to @player
    else
      render 'edit'
    end
  end

  def destroy
    @player.destroy
    flash[:success] = "Player deleted successfully"
    redirect_to players_url
  end

  private

  def sort_column
    params[:sort] ? params[:sort] : "name"
  end

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
