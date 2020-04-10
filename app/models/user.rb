# frozen_string_literal: true

# Users of the application
#
class User < ApplicationRecord

  has_secure_password

  validates :email_address, 'valid_email_2/email': { mx: true, disposable: true }
  validates :email_address, uniqueness: true
  validates :name, presence: true, length: { minimum: 2, maximum: 255 }

  has_many :trackers

end
