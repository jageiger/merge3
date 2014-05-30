#keep
class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.string :ip
      t.string :user_name
      t.string :password
      t.integer :user_id

      t.timestamps
    end
  end
end
