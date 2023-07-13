class Category < ApplicationRecord

  has_many :programs, dependent: :destroy
  validates :name, presence:true
end
