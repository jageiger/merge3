#keep
class CreateJoins < ActiveRecord::Migration
  def change
    create_table :joins do |t|
      t.integer :user_id
      t.integer :miner_id
      t.string :txid
      t.datetime :lease_creation
      t.datetime :lease_expiration

      t.timestamps
    end
  end
end
