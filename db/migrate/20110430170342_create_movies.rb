class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :name
      t.string :tagline
      t.text :description
      t.integer :year
      t.string :url
      t.string :wikipedia_url
      t.integer :length
      t.string :genre
      t.string :subgenre
      t.decimal :rating
      t.string :cached_slug
      t.timestamps
    end
    
  #  add_index "movies", ["cached_slug"], :name => "cached_slug"
    
  end

  def self.down
    drop_table :movies
  end
end
