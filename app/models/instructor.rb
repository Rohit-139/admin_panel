class Instructor < User
  # has_secure_password
  # has_many :programs

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
