class CreateLocales < ActiveRecord::Migration
  def self.up
    create_table :locales do |t|
      t.string :name
      t.string :country
      t.text :description
      t.string :cached_slug
      t.timestamps
    end
  end

  def self.down
    drop_table :locales
  end
end
