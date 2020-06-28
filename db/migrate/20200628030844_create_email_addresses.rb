class CreateEmailAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :email_addresses, id: :uuid do |t|

      t.timestamps
      t.references :user, type: :uuid, foreign_key: true, index: true, null: false
      t.string :address, null: false
      t.index :address, unique: true, where: "verified_at IS NOT NULL"
      t.uuid :verification_token, null: false
      t.datetime :verified_at
      t.boolean :default, null: false, default: false
      t.index [:user_id, :default], unique: true
    end
  end
end
