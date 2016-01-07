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

    respond_to do |format|
      if @hangman_state.save
        format.html { redirect_to @hangman_state, notice: 'Hangman state was successfully created.' }
        format.json { render :show, status: :created, location: @hangman_state }
      else
        format.html { render :new }
        format.json { render json: @hangman_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hangman_states/1
  # PATCH/PUT /hangman_states/1.json
  def update
    respond_to do |format|
      if @hangman_state.update(hangman_state_params)
        format.html { redirect_to @hangman_state, notice: 'Hangman state was successfully updated.' }
        format.json { render :show, status: :ok, location: @hangman_state }
      else
        format.html { render :edit }
        format.json { render json: @hangman_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hangman_states/1
  # DELETE /hangman_states/1.json
  def destroy
    @hangman_state.destroy
    respond_to do |format|
      format.html { redirect_to hangman_states_url, notice: 'Hangman state was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hangman_state
      @hangman_state = HangmanState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hangman_state_params
      params[:hangman_state].permit(:word_to_guess, :number_of_lives)
    end
end
