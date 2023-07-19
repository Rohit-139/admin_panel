class Category < ApplicationRecord

  has_many :programs, dependent: :destroy
  validates :name, presence:true
  has_many :enrolls, through: :programs

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["enrolls", "programs"]
  end
end
