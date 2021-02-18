class Team < ApplicationRecord
  has_many :players
  validates :name, presence: true, uniqueness: true

  scope :alpha, -> { order(:name)}
  # Ex:- scope :active, -> {where(:active => true)}

 
end
