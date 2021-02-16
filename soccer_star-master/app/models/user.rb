class User < ApplicationRecord
    has_secure_password
    
    has_many :reviews
    has_many :reviewed_players, through: :reviews, source: :player
    has_many :players

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

    #def self.github_signup(auth)
      #User.where(email: auth[:info][:email]).first_or_initialize do |u|  (same thing)
    #  self.find_or_create_by(email: auth[:info][:email]) do |u|
    #    u.password = SecureRandom.hex
    #  end 
    #end 

    
    

end
 