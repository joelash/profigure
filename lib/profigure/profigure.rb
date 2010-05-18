class Profigure
  class << self
    def load(configs_dir, environment=nil)
      hash = file_contents("defaults", configs_dir)
      if environment
        yaml_result = file_contents(environment, configs_dir)
        merged_with_reference = load_referenced_config_from configs_dir, yaml_result
        hash.recursive_merge! merged_with_reference
      end
      hash["environment"] = environment
      MoStash.new hash
    end 

    private

    def file_contents(environment, configs_dir)
      file = "#{configs_dir}/#{environment}.yml"
      content = run_erb IO.read(file)
      YAML.load content
    end 

    def run_erb(data)
      ERB.new( data ).result
    end

    def load_referenced_config_from( configs_dir, config_hash )
      config_like_file = config_hash["profigure_like"]
      return config_hash unless config_like_file
      config_like = file_contents( config_like_file, configs_dir )
      config_like.recursive_merge! config_hash
    end

  end
end

