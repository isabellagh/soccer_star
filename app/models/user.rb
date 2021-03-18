class User < ApplicationRecord
    has_secure_password
    
    has_many :reviews, dependent: :destroy
    has_many :reviewed_players, through: :reviews, source: :player, dependent: :destroy
    has_many :players, dependent: :destroy

    before_save { self.email = email.downcase }
    validates :email, uniqueness: true, presence: true
    validates :name, presence: true


    #def self.google_signup(auth)
      #User.where(email: auth[:info][:email]).first_or_initialize do |u|  (same thing)
    #  self.find_or_create_by(email: auth[:info][:email]) do |u|
    #  u.password = SecureRandom.hex
      #u.name
    #  end 
    #end 

 end
 