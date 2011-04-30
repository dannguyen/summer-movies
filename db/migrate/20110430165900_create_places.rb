class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :name
      t.string :category
      t.text :description
      t.string :address
      t.string :zip
      t.string :phone
      t.string :city
      t.string :state
      t.integer :locale_id
      t.string :url
      t.float :lat
      t.float :lng
      t.string :cached_slug
      t.timestamps
    end
    
    add_index "places", ["cached_slug"], :name => "cached_slug"
    add_index "places", ["locale_id"], :name => "locale_id"
    add_index "places", ["category"], :name => "category"
    
    
  end

  def self.down
    drop_table :places
  end
end
