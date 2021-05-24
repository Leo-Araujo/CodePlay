class Instructor < ApplicationRecord
  has_many :courses

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_one_attached :profile_picture
end