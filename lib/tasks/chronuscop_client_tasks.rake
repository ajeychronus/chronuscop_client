namespace :chronuscop do
  desc "Rake task to upload english keys and translations from the yaml file."
  task :deploy => :environment do



    require 'yaml'
    require 'xmlsimple'
    require 'mechanize'
    require 'redis'


    # function to flatten a hash separating each level with '.' character.
    def make_hash_one_dimensional(input = {}, output = {}, options = {})
      input.each do |key, value|
        key = options[:prefix].nil? ? "#{key}" :
          "#{options[:prefix]}#{options[:delimiter]||"_"}#{key}"
        if value.is_a? Hash
          make_hash_one_dimensional(value, output, :prefix => key,:delimiter => ".")
        else
          output[key]  = value
        end
      end
      output
    end

    # Reading the configuration yaml file.
    chronuscop_config = YAML.load_file('./config/chronuscop.yml')

    if( ! RAILS_ENV)            # if no option is passed from the command line
      RAILS_ENV = "development"
    end

    # reading the yaml files.
    h = YAML.load_file('./config/locales/default.yml')

    # converting the yaml file into a one dimensional hash.
    one_dim_hash = make_hash_one_dimensional(h)

    # Adding the initial set of key-value pairs into
    # the redis database as english key-value pairs.

    # Creating the redis client object.
    redis_agent = Redis.new(:db => chronuscop_config[RAILS_ENV]["redis_db_number"])
    one_dim_hash.each do |key,value|
      new_key = key.sub(/default/,"en")
      if(!redis_agent[new_key]) then # If nil then assign default value.
        redis_agent[new_key] = value
      end
    end

    # converting the 1-D hash into xml string.
    txs = XmlSimple.xml_out(one_dim_hash)

    mechanize_agent = Mechanize.new
    mechanize_agent.post("#{chronuscop_config[RAILS_ENV]["chronuscop_server_address"]}/projects/#{chronuscop_config[RAILS_ENV]["project_number"]}/translations/add/?auth_token=#{chronuscop_config[RAILS_ENV]["api_token"]}","translations_xml_string" => txs)

  end
end
