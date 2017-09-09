class PhasesController < ApplicationController
  before_action :set_tournament, only: [:index, :create, :new]
  before_action :set_phase, only: [:show, :edit, :update, :destroy]

  def index
    @phases = @tournament.phases
  end

  def show
  end

  def new
    @phase = Phase.new
  end

  def edit
  end

  def create
    @phase = Phase.new(phase_params)

    respond_to do |format|
      if @phase.save
        format.html { redirect_to @phase, notice: 'Phase was successfully created.' }
        format.json { render :show, status: :created, location: @phase }
      else
        format.html { render :new }
        format.json { render json: @phase.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phase.update(phase_params)
        format.html { redirect_to @phase, notice: 'Phase was successfully updated.' }
        format.json { render :show, status: :ok, location: @phase }
      else
        format.html { render :edit }
        format.json { render json: @phase.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phase.destroy
    respond_to do |format|
      format.html { redirect_to phases_url, notice: 'Phase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def set_phase
    @phase = Phase.find(params[:id])
  end

  def phase_params
    params
      .require(:phase)
      .permit(:name, :type)
  end
end
