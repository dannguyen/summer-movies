class Place < ActiveRecord::Base
  validates_uniqueness_of :name
  
  belongs_to :locale
end
