namespace :import do
  
  desc "Read data from local files"
  task :read_seeds => :environment do
    require "#{Rails.root}/lib/tasks/foo_import.rb"
    p = FooImport.new
    p.verify_seeds

    p.seed_names do |seed_name|
      p.read_seed(seed_name).each do |seed|
        
      end
    end
    
  end
  
  desc "Gets info from google docs" 
  task :fetch_seeds => :environment do
    require "#{Rails.root}/lib/tasks/foo_import.rb"
    p = FooImport.new
    p.bootstrap
    
    p.seed_names.each do |seed_name|
      puts "Getting #{seed_name}"
      p.fetch_and_save_seed(seed_name)
      puts "\tSuccess"
    end
  end
end

