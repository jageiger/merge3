#keep
class CreateMiners < ActiveRecord::Migration
  def change
    create_table :miners do |t|
      t.string :name
      t.string :ip
      t.integer :state, :default => 0
      t.integer :pool_id
      t.integer :user_id, :default => 1

      t.timestamps
    end
  end
end
