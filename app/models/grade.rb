# frozen_string_literal: true

# A level of achievement for a tracker
#
class Grade < ApplicationRecord

  ALLOWED_COLORS = %w[
    red orange yellow olive green teal blue violet purple pink brown grey black
  ].freeze

  belongs_to :tracker

  has_many :entries

  validates :label, length: { minimum: 1, maximum: 16 }
  validates :color, inclusion: { in: ALLOWED_COLORS }

end
