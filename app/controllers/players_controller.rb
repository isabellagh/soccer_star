class PlayersController < ApplicationController
  before_action :require_user
  before_action :set_player
  before_action :redirect_if_not_owner, only: [:edit, :update]
 
  def new
    @player = Player.new
    @player.build_team
  end

  def create
    @player = Player.new(player_params)
    @player.user_id = session[:user_id]

    if @player.save
      flash[:success] = "Object successfully created"
      redirect_to player_path(@player)
    else
      @player.build_team
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @players = @user.players.order_by_rating.alpha
    else
      @players = Player.order_by_rating.alpha
    end
    if params[:q] && !params[:q].empty?
      @players = @players.search(params[:q])
    end
  end 

  def edit
   set_player
  end 

  def update 
   set_player
   if @player.update(player_params)
     flash[:success] = "Player was updated successfully"
     redirect_to player_path(@player)
   else 
     render 'edit'
    end 
 end 

  def show
    set_player
  end 

  def destroy
    set_player.destroy
   flash[:success] = "Player deleted successfully"
   redirect_to players_path
  end 
  
  private

  def player_params
    params.require(:player).permit(:name, :gender, :team_id, :image, :position, :bio, :user_id, team_attributes: [:name, :country])
  end 

  def set_player
    @player = Player.find_by_id(params[:id])
  end

end
