namespace :import do
  
  desc "Read data from local files"
  task :read_seeds => :environment do
    require "#{Rails.root}/lib/tasks/foo_import.rb"
    p = FooImport.create
    p.verify_seeds
    
    
    place_seed = p.seed_hash('places')
    Place.destroy_all
    p.read_seed('places').each do |entry|
      atts = place_seed.attributes.inject({}){|hsh, att|
        hsh[att] = entry[att]
        hsh
      }
      Place.create(atts)
    end
    
  end
  
  desc "Gets info from google docs" 
  task :fetch_seeds => :environment do
    require "#{Rails.root}/lib/tasks/foo_import.rb"
    p = FooImport.create
    p.bootstrap
    
    p.seed_names.each do |seed_name|
      puts "Getting #{seed_name}"
      p.fetch_and_save_seed(seed_name)
      puts "\tSuccess"
    end
  end
end

