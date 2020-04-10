# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries, id: :uuid do |t|

      t.date :date, null: false
      t.references :tracker, type: :uuid, foreign_key: true, index: true, null: false
      t.references :grade, type: :uuid, foreign_key: true, index: true, null: false
      t.index %i[tracker_id date], unique: true

    end
  end
end
