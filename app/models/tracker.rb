# frozen_string_literal: true

# A single category of journal entries for a user
#
class Tracker < ApplicationRecord

  belongs_to :user

  has_many :entries
  has_many :grades

  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :name, uniqueness: { scope: :user }

end
