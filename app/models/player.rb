class Player < ApplicationRecord
    belongs_to :team 
    belongs_to :user #creator
    has_many :reviews, dependent: :destroy
    has_many :users, through: :reviews
    has_one_attached :image
    accepts_nested_attributes_for :team
    #has_many_attached :images
    

    validates :name, presence: true
    validate :not_a_duplicate

    scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(stars) asc')}
    #after_commit :add_default_image, on: [:create, :update]

    def self.alpha
      order(:name)
    end 
 
  def team_attributes=(attributes)
    self.team = Team.find_or_create_by(attributes) if !attributes['name'].empty?
    self.team
  end 

  def self.search(params)
    joins(:team).where("LOWER(players.name) LIKE ? OR LOWER(teams.name) LIKE ?", "%#{params}%", "%#{params}%") 
   end


  #def thumbnail
  #  self.image.variant(resize: "100x100")
  #end 


private 

def not_a_duplicate
  #throw an error if already exist a player with the name and team
  @player = Player.find_by(name: name, team_id: team_id)
    if !!@player && @player != self
      errors.add(:name, 'has already been added for that team')
    end
end 

 # def add_default_image
 # unless image.attached?
 #   self.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.jpeg")), filename: 'default.jpg' , content_type: "image/jpg")
 # end
#end

end
