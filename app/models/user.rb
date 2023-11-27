class User < ApplicationRecord
  has_many :programs, dependent: :destroy
  has_many :enrolls, dependent: :destroy
  belongs_to :category, optional: true
  has_many :subcategories, through: :category

  validates :category_id, presence: true, if: :check_instructor?
  validates :name, presence:true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :email, presence:true, uniqueness:true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, presence: true#, format: {with: /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "password", "type", "country_name", "state", "city", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["enrolls", "programs", "category", "subcategories"]
  end

  def instructor?
    type == 'Instructor'
  end

  def customer?
    type == 'Customer'
  end

  def check_instructor?
    self.type == 'Instructor'
  end
end
