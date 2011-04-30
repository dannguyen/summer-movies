class FooImport
  private_class_method :new
  load "#{Rails.root}/lib/tasks/seed.rb"
  
   def FooImport.create(*args, &block)
     @@inst ||= new(*args, &block)
   end
 
  
  def initialize(opt={})
    @privates = YAML.load_file("#{RAILS_ROOT}/config/privates.yml")
    @seeds = APP_CONFIG['imports']['seeds'].inject({}) do |hash, seed|
      seed_name = seed[0]; seed_o = seed[1]
      hash[seed_name] = Seed.create(seed_name, seed_o)
      hash
    end
  end
  
  def seed_hashes
     @seeds
  end
  
  def seed_private_hashes
    @privates['imports']['seeds']
  end
  
  def seed_hash(seed_name)
    seed_hashes[seed_name]
  end
  
  def seed_prviate_hash(seed_name)
    seed_private_hashes[seed_name]
  end
  
  def seed_names
     seed_hashes.keys
  end
   
  def get_seed_remote_path(seed_name)
    s = seed_prviate_hash(seed_name)
    "https://spreadsheets.google.com/spreadsheet/pub?hl=en&hl=en&key=#{s['key']}&single=true&gid=#{s['id']}&output=txt"
  end
  
  def get_seed_local_path(seed_name)
    "#{seeds_store_path}/#{seed_name}.yml"
  end
  
  def read_seed(seed_name)
    # converts local tab-delimited textfile to array of objects
    puts "\tReading seed #{seed_name}:\t#{get_seed_local_path(seed_name)}"
    headers, lines = nil
    File.open(get_seed_local_path(seed_name), 'r'){|f|
      headers = f.readline.split("\t").map{|t| t.strip}
      lines = f.readlines.map{|r| r.split("\t").map{|t| t.strip}}
    }
    
    lines.inject([]) do |arr, line|
      arr << headers.each_with_index.inject({}){|hash, (key, index)| 
        hash[key] = line[index]
        hash
      }
    end
    
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
      
      seed = seed_hash(seed_name)
      
      
      # make sure all seed files have the expected headers
      File.open(get_seed_local_path(seed_name), 'r'){|f| 
        headers= f.readline.strip.split("\t")
        expected_headers = seed.headers
        expected_headers.each do |ex_header|
          raise "In seed #{seed.name}, #{ex_header} was not found in the seed file" unless headers.index(ex_header)
        end
      }
      
    end
  end

  
  
  
  
  def FooImport.remote_fetch(url, options={})
    puts "Fetching #{url}"
    RestClient.get(url).body
  end
  
  private
  
  
  def save_seed(seed_name, body)
    File.open(get_seed_local_path(seed_name), 'w'){|f| f.write(body) }
  end
  
  
  def seeds_store_path
    "#{Rails.root}/#{APP_CONFIG['paths']['seeds']}"    
  end


end