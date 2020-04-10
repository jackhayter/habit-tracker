# frozen_string_literal: true

class CreateGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :grades, id: :uuid do |t|

      t.timestamps
      t.references :tracker, type: :uuid, foreign_key: true, index: true, null: false
      t.string :label, null: false
      t.string :color, null: false
      t.index :label
    end
  end
end
