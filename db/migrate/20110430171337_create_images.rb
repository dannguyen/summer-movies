class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :filename
      t.text :source_image_url
      t.string :caption
      t.string :credit
      t.integer :entity_id
      t.string :entity_type
      t.text :source_page_url
      t.timestamps
    end
    add_index "images", ["entity_id"], :name => "entity_id"
    add_index "images", ["entity_type"], :name => "entity_type"
    
  end

  def self.down
    drop_table :images
  end
end
