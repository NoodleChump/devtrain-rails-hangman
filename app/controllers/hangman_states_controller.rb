class HangmanStatesController < ApplicationController
  before_action :set_hangman_state, only: [:show, :edit, :update, :destroy]

  # GET /hangman_states
  # GET /hangman_states.json
  def index
    @hangman_states = HangmanState.all
  end

  # GET /hangman_states/1
  # GET /hangman_states/1.json
  def show
    @guess = Guess.new
  end

  # GET /hangman_states/new
  def new
    @hangman_state = HangmanState.new
  end

  # GET /hangman_states/1/edit
  def edit
  end

  # POST /hangman_states
  # POST /hangman_states.json
  def create
    @hangman_state = HangmanState.new(hangman_state_params)

    if @hangman_state.save
      flash[:success] = "Game created successfully"
      redirect_to @hangman_state
    else
      render 'new'
    end
  end

  # PATCH/PUT /hangman_states/1
  # PATCH/PUT /hangman_states/1.json
  def update
    if @hangman_state.update(hangman_state_params)
      flash[:success] = "Game updated successfully"
      redirect_to @hangman_state
    else
      render 'edit'
    end
  end

  # DELETE /hangman_states/1
  # DELETE /hangman_states/1.json
  def destroy
    @hangman_state.destroy
    flash[:success] = "Game deleted successfully"
    redirect_to hangman_states_url
  end

  def submit_guess
    @guess = Guess.new(guess_params)
    @hangman_state = @guess.hangman_state

    if @guess.save
      #flash[:success] = "Game created successfully"
      redirect_to @guess.hangman_state
    else
      render 'show'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hangman_state
    @hangman_state = HangmanState.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hangman_state_params
    params[:hangman_state].permit(:word_to_guess, :number_of_lives, :player_id)
  end

  def guess_params
    params[:guess].permit(:letter, :hangman_state_id) #TODO hangman state id?
  end
end
