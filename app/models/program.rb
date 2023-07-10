class Program < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :enrolls, dependent: :destroy, class_name: 'Enroll'


  enum :status,[:active, :inactive]
  has_one_attached :video

  validates :name, presence:true
  validates :category, presence:true
  validates :status, presence:true
  validates :video, presence: true
end
