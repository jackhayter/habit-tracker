# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|

      t.timestamps
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.uuid :verification_token, null: false
      t.datetime :verified_at
      t.index :email_address, unique: true
    end
  end
end
