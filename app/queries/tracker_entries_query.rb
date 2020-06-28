# frozen_string_literal: true

# Loads all tracker entries for a user
#
class TrackerEntriesQuery < ApplicationQuery

  def initialize(relation)
    @relation = relation
  end

  def call
    @relation
  end

end
