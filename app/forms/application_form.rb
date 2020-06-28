# frozen_string_literal: true

class FormField

  include ActionView::Context
  include ActionView::Helpers::TagHelper

  attr_accessor :form, :name, :options

  def initialize(form:, name:, type:, options: {})
    @form = form
    @name = name
    @options = options.to_h.merge(name: name, id: name, type: type)
  end

  def render(_value)
    wrapper.render do
      tag.small error, class: 'form-text text-error' if error
      tag.input render_options do
        form.instance_variable_get(':@' + name)
      end
    end
  end

  private

  def render_options
    options[:class] ||= 'form-control'
    options[:class] += ' is-invalid' if error
    options
  end

  def error
    @error ||= form.errors[@name]
  end

  def wrapper
    FieldWrapper.parse(@options.dig(:wrapper) || @form.default_wrapper)
  end

end

class FieldWrapper

  include ActionView::Context
  include ActionView::Helpers::TagHelper

  def self.parse(wrapper)
    return wrapper if wrapper.is_a?(FieldWrapper)
    return from_hash(wrapper) if wrapper.is_a?(Hash)
    return new(tag_type: wrapper) if %i[string symbol].include?(wrapper)
    return default_wrapper if wrapper.nil?
    raise 'invalid field wrapper'
  end

  def self.from_hash(wrapper_options)
    new(
      tag_type: wrapper_options[:tag_type] || wrapper_options[:tag],
      options: wrapper_options[:options] || {}
    )
  end

  def self.default_wrapper
    new(tag_type: 'div', options: { class: 'form-group' })
  end

  def initialize(tag_type:, options: {})
    @tag_type = tag_type
    @options = options
  end

  def render(_value)
    content_tag(@tag_type, @options) do
      yield
    end
  end

end

# Superclass for all form objects in the application
#
class ApplicationForm

  include ActiveModel::Model
  include ActiveModel::Validations
  include ActionView::Context
  include ActionView::Helpers::TagHelper

  cattr_accessor :fields, :default_wrapper

  def self.field(name, type = :text, options = {})
    @@fields ||= []
    @@fields << FormField.new(form: self, name: name, type: type, options: options)
  end

  def self.wrap_in(tag_type, options = {})
    @@default_wrapper = FieldWrapper.new(tag_type: tag_type, options: options)
  end

  def render

    self.errors ||= ActiveModel::Errors.new(self)

    puts inspect
    puts fields.inspect

    tag.form do
      fields.to_a.collect(&:render)
    end
  end
  # def submit!
  #   raise FormSubmissionError unless valid? && submit
  # end

  # def submit
  #   raise FormSubmissionError('Override this method')
  # end

  # def status
  #   errors ? 422 : @status || 200
  # end

  # class FormSubmissionError < StandardError
  # end
end
