class Review < ApplicationRecord
  belongs_to :user
  belongs_to :player

  validates :title, :content, presence: true
  validates :stars, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 6}
  validates :player_id, uniqueness: { scope: :user_id, message: "has already been reviewed by you"}
  #validates_associated :player
  scope :order_by_created_at, -> {left_joins(:players).group(:id).order('(created_at) desc')}



end
