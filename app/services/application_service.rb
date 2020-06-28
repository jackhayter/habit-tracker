# frozen_string_literal: true

# Superclass for service objects within this application
#
class ApplicationService
  # extend ActiveModel::Naming
  include ActiveModel::Model
  # include ActiveModel::Validations

  attr_accessor :result

  # Safely execute a service object within a transaction, with graceful error handling
  #
  def self.execute(args)
    # Ensure the service object passes essential validations before execution
    #
    service = new(args)
    return service unless service.valid?

    # Execute the service within a transaction since we care about data integrity
    #
    ActiveRecord::Base.transaction do
      service.execute!
    end

    # Ensure a result value was set before returning the service object itself
    #
    raise 'No result was set' if service.result.nil?

    service

  # Merge invalid record's errors into the service errors object
  #
  rescue ActiveRecord::RecordInvalid => e
    errors.merge!(e.record.errors)
  end

  # Execute a service object without any validation or transaction protection
  #
  def self.execute!(args)
    service = new(args)
    # service.validate!
    # service.execute!
    service.execute! if service.valid?
    service
  end

  # Subclasses should perform their business logic within this method
  #
  def execute!
    raise 'Override this method'
  end

  # Allow developers to override the default status code returned
  #
  attr_writer :status_code

  # Assume correctly executed services are 200, ones with errors are 422
  #
  def status_code
    @status_code || errors.empty? ? 200 : 422
  end
end
