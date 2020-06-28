# frozen_string_literal: true

# Stores user email addresses
#
class EmailAddress < ApplicationRecord

  belongs_to :user

  validates :email_address, 'valid_email_2/email': { mx: true, disposable: true }
  validates :email_address, uniqueness: true
  validates :verified_at, allow_nil: true, date: true
  validates :default, uniqueness: { scope: :user }, if: :default?

  scope :default, -> { where(default: true) }
  scope :verified, -> { where.not(verified_at: nil) }
  scope :unverified, -> { where(verified_at: nil) }

end
