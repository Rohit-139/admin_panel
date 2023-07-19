class Enroll < ApplicationRecord
  belongs_to :program
  belongs_to :user

  has_one :category, through: :program
  # enum :level,[:started, :finished]
  validates :level, presence: true, inclusion: {in:  %w(started finished), message: "%{value} is not valid"}
  validates :program_id, uniqueness: {scope: :user_id, message:"You have already enrolled in this course"}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "level", "name", "program_id", "updated_at", "user_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["category", "program", "user"]
  end
end
