class Enroll < ApplicationRecord
  belongs_to :program
  belongs_to :user

  # enum :level,[:started, :finished]
  validates :level, presence: true, inclusion: {in:  %w(started finished), message: "%{value} is not valid"}
  validates :program_id, uniqueness: {scope: :user_id, message:"You have already enrolled in this course"}
end
