class Program < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :enrolls, dependent: :destroy

  has_one_attached :video

  validates :name, presence:true
  validates :video, presence: true
  validates :status, presence:true, inclusion: {in: %w(active inactive), message: "%{value} is not valid"}

end
