# frozen_string_literal: true

# A single tracker entry on a specific date
#
class Entry < ApplicationRecord

  belongs_to :tracker
  belongs_to :grade

  validates :date, date: true, uniqueness: { scope: :tracker }

end
