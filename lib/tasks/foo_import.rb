class FooImport
  
 
  
  def initialize(opt={})
    @privates = YAML.load_file("#{RAILS_ROOT}/config/privates.yml")
  end
  
 
  
  def seed_hashes
    @privates['imports']['seeds']  
  end
  
  def seed_hash(seed_name)
    seed_hashes[seed_name]
  end
  
  def seed_names
     seed_hashes.keys
   end
   
  def get_seed_remote_path(seed_name)
    s = seed_hash(seed_name)
    "https://spreadsheets.google.com/spreadsheet/pub?hl=en&hl=en&key=#{s['key']}&single=true&gid=#{s['id']}&output=txt"
  end
  
  def get_seed_local_path(seed_name)
    "#{seeds_store_path}/#{seed_name}.yml"
  end
  
  def read_seed(seed_name)
    # converts local tab-delimited textfile to array of objects
    puts "Reading seed #{seed_name}:\t#{get_seed_local_path(seed_name)}"
  end
  
  
  ### remote stuff
  def fetch_seed(seed_name)
    FooImport.remote_fetch get_seed_remote_path(seed_name)
  end
  
 
  def fetch_and_save_seed(seed_name)
    body = fetch_seed(seed_name)
    save_seed(seed_name, body)
  end
  
  ## some validators
  def bootstrap
     # initialize the local environment
     FileUtils.makedirs(seeds_store_path)
  end

  def verify_seeds
    # make sure all seeds exist
    seed_names.each do |seed_name|
      local_path = self.get_seed_local_path(seed_name)
      if !File.exists?(local_path)
        raise "#{local_path} doesn't exist!"
      end
    end
  end

  
  
  
  
  
  private
  def FooImport.remote_fetch(url, options={})
    puts "Fetching #{url}"
    RestClient.get(url).body
  end
  
  def save_seed(seed_name, body)
    File.open(get_seed_local_path(seed_name), 'w'){|f| f.write(body) }
  end
  
  
  def seeds_store_path
    "#{Rails.root}/#{@privates['paths']['seeds']}"    
  end


end