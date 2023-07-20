class Program < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :enrolls, dependent: :destroy

  has_one_attached :video

  validates :name, presence:true
  validates :video, presence: true
  validates :status, presence:true, inclusion: {in: %w(active inactive), message: "%{value} is not valid"}

  def self.ransackable_attributes(auth_object = nil)
    ["blob_id", "created_at", "id","status", "name", "record_id", "record_type"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "enrolls", "user", "video_attachment", "video_blob"]
  end

  # def self.ransackable_attributes(auth_object = nil)
  #   ["blob_id", "created_at", "id", "name", "record_id", "record_type"]
  # end
end
