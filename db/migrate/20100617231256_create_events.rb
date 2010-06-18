class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :stop_sales
      t.integer :quantity
      t.decimal :price
      t.string :currency
      t.integer :max_tix
      t.integer :venue_id
      t.integer :user_id

      t.timestamps
    end
  add_index :events, :user_id
  add_index :events, :start_time
  end

  def self.down
    drop_table :events
  end
end
