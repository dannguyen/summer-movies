class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :category
      t.string :name
      t.text :description
      t.integer :place_id
      t.integer :movie_id

      t.timestamps
    end
    add_index "events", ["place_id"], :name => "place_id"
    add_index "events", ["movie_id"], :name => "movie_id"
    
  end

  def self.down
    drop_table :events
  end
end
