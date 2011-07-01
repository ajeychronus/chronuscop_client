namespace :chronuscop do
  desc "Rake task to upload english keys and translations from the yaml file."
  task :deploy => :environment do



    require 'yaml'
    require 'xmlsimple'
    require 'mechanize'


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

    # reading the yaml file.
    h = YAML.load_file('./config/locales/en.yml')

    # converting the yaml file into a one dimensional hash.
    one_dim_hash = make_hash_one_dimensional(h)

    # converting the 1-D hash into xml string.
    txs = XmlSimple.xml_out(one_dim_hash)

    mechanize_agent = Mechanize.new
    mechanize_agent.post("http://localhost:3000/projects/1/translations/add/?auth_token=BgIQ-Dh2VVvb6F3lN6zX","translations_xml_string" => txs)

  end
end
