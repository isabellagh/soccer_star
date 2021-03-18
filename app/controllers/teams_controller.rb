class TeamsController < ApplicationController
  before_action :require_user

  def new
    @team = Team.new
  end

  def index
    @teams = Team.alpha
  end

  def show
    @team = Team.find_by_id(params[:id])
  end
  
  private

  def team_params
    params.require(:team).permit(:name, :professional_team, :country)
  end
  
end
