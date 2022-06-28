class User < ApplicationRecord
  #before_save :create_remember_token
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def remember_me
    true
  end

  has_one :profile, dependent: :destroy

  has_many :items
end
