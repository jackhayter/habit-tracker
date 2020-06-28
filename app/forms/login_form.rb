# frozen_string_literal: true

# Handles login actions
#
class LoginForm

  include ActiveModel::Model

  def errors_for(field)
    errors.messages[field]
  end

  def class_for(field)
    classes = ['form-control']
    classes << 'is-invalid' if errors_for(field).present?
    classes
  end

  attr_accessor :email_address, :password
  attr_reader :authenticated_user

  validates :email_address, presence: true, 'valid_email_2/email': true
  validates :password, presence: true

  validate do
    service = AuthenticationService.execute(email_address: email_address, password: password)
    @authenticated_user = service.result if service.result.is_a?(User)
  end

  def submit; end

end
