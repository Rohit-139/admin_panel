class Category < ApplicationRecord
  has_many :programs, dependent: :destroy
  validates :name, presence:true
  has_many :enrolls, through: :programs
  has_many :subcategories, dependent: :destroy
  has_many :users

  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["blob_id", "created_at", "id", "name", "updated_at", 'record_type', 'record_id']
  end

  def self.ransackable_associations(auth_object = nil)
    ["enrolls", "programs", 'subcategories', 'users', 'image_attachment', 'image_blob']
  end

end
