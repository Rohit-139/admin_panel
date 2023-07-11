class Category < ApplicationRecord
  has_many :users, through: :programs
  has_many :programs, dependent: :destroy  
  # has_many :categories, through: :user
  validates :name, presence:true
end
