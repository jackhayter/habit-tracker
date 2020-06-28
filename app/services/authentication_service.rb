# frozen_string_literal: true

# Authenticates users
#
class AuthenticationService < ApplicationService

  attr_accessor :email_address, :password

  def execute!

    # Find the email address object and user, prioritizing verified ones first
    #
    email = EmailAddress.order(verified_at: :desc).find_by(address: email_address)
    user  = email&.user

    # Return the user object if authentication was okay
    #
    if user&.authenticate(password)
      self.result = user
    else
      errors.add(:base, 'authentication failed')
      self.result = false
    end

  end

end
