class Enroll < ApplicationRecord
  belongs_to :program
  belongs_to :user

  enum :level,[:started, :finished]
  # validates :status, presence: true, default: 'started'
  validates :program_id, uniqueness: {scope: :user_id, message:"You have already enrolled in this course"}
end
