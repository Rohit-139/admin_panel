class User < ApplicationRecord
  has_many :programs, dependent: :destroy
  has_many :enrolls, dependent: :destroy
  has_many :categories, through: :programs

  validates :name, presence:true
  validates :email, presence:true, uniqueness:true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, presence: true
end
