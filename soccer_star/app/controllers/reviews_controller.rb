class ReviewsController < ApplicationController
  before_action :require_user

  def new
    if set_player
      @review = @player.reviews.build
    else 
      @review = Review.new
    end
  end 

  def create 
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end 

  def show 
    set_review
  end 

  def index
    if set_player
      @reviews = @player.reviews 
      #nested
    else 
      @reviews = Review.all.includes(:player, :user) #.includes(:player, :user) less queries?
      #not nested
    end 
  end
  
  private

  def set_player
    @player = Player.find_by_id(params[:player_id])
  end

  def player_params
    params.require(:player).permit(:name, :gender, :team_id, :image, team_attributes: [:name, :country])
  end 

  def set_review
    @review = Review.find_by(id: params[:id])
    redirect_to reviews_path if !@review
  end

  def review_params
    params.require(:review).permit(:player_id, :stars, :title, :content)
  end 

end
