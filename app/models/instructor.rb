class Instructor < ApplicationRecord
  has_many :courses, dependent: :restrict_with_exception

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_one_attached :profile_picture
end