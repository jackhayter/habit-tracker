# frozen_string_literal: true

class CreateTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :trackers, id: :uuid do |t|

      t.timestamps
      t.references :user, type: :uuid, foreign_key: true, index: true
      t.string :name, null: false
    end
  end
end
