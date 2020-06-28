# frozen_string_literal: true

# Users of the application
#
class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true, length: { minimum: 2, maximum: 255 }

  has_many :trackers
  has_many :email_addresses

  has_one :email_address, -> { default }

end
