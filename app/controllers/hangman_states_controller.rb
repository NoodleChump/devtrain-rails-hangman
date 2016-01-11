class HangmanStatesController < ApplicationController
  before_action :set_hangman_state, only: [:show, :edit, :update, :destroy, :submit_guess] #TODO Move into guess controller (nesting)
  helper_method :sort_column, :sort_direction

  #TODO Rename to GamesController

  def index
    @hangman_states = HangmanState.all
    apply_sort
  end


  def show
    @guess = Guess.new
  end

  def new
    @hangman_state = HangmanState.new
  end

  def edit
  end

  def create
    @hangman_state = HangmanState.new(hangman_state_params)

    if @hangman_state.save
      flash[:success] = "Game created successfully"
      redirect_to @hangman_state
    else
      render 'new'
    end
  end

  def update
    if @hangman_state.update(hangman_state_params)
      flash[:success] = "Game updated successfully"
      redirect_to @hangman_state
    else
      render 'edit'
    end
  end

  def destroy
    @hangman_state.destroy
    flash[:success] = "Game deleted successfully"
    redirect_to hangman_states_url
  end

  def submit_guess
    @guess = Guess.new(guess_params)
    if @guess.save
      redirect_to @hangman_state
    else
      render 'show'
    end
  end

  private

  def set_hangman_state
    @hangman_state = HangmanState.find(params[:id])
  end

  def sort_column
    params[:sort] ? params[:sort] : "player_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def hangman_state_params
    params[:hangman_state].permit(:word_to_guess, :number_of_lives, :player_id)
  end

  def guess_params
    params[:guess].permit(:letter, :hangman_state_id)
  end

  def apply_sort
    case sort_column
    when "player_name"
      @hangman_states = @hangman_states.sort_by { |hangman_state| hangman_state.player.name }
    when "progress"
      @hangman_states = @hangman_states.sort_by { |hangman_state| hangman_state.progress }
    when "remaining_guesses"
      @hangman_states = @hangman_states.sort_by { |hangman_state| hangman_state.number_of_guesses_remaining }
    else
      @hangman_states = @hangman_states.sort_by { |hangman_state| hangman_state.player.name }
    end

    if sort_direction == "desc"
      @hangman_states.reverse!
    end
  end
end
