class Instructor < ApplicationRecord
  has_many :courses

  has_one_attached :profile_picture
end