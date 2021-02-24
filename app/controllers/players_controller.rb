class PlayersController < ApplicationController
  before_action :require_user
 
  def new
    @player = Player.new
    @player.build_team
  end

  def create
    @player = Player.new(player_params)
    @player.user_id = session[:user_id]

    if @player.save
      #@player.image.purge
      #@player.image.attach(params[:player][:image])
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
   @player = Player.find_by_id(params[:id])
  end 

  def update 
   @player = Player.find_by_id(params[:id])
   if @player.update(player_params)
     flash[:success] = "Player was updated successfully"
     redirect_to player_path(@player)
   else 
     render 'edit'
    end 
 end 

  def show
    @player = Player.find_by_id(params[:id])
  end 

  def destroy
   Player.find(params[:id]).destroy
   flash[:success] = "Player deleted successfully"
   redirect_to players_path
  end 
  
  private

  def player_params
    params.require(:player).permit(:name, :gender, :team_id, :image, :position, team_attributes: [:name, :country])
  end 

  def set_player
    @player = Player.find_by_id(params[:player_id])
    redirect_to players_path if !@player
  end

end
