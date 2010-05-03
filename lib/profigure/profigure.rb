class Profigure
  class << self
    def load(configs_dir, environment=nil)
      hash = YAML.load(file_contents("defaults", configs_dir))
      if environment
        contents = file_contents(environment, configs_dir)
        yaml_result = YAML.load(contents)
        hash.recursive_merge! yaml_result
      end
      hash["environment"] = environment
      MoStash.new hash
    end 

    def file_contents(environment, configs_dir)
      file = "#{configs_dir}/#{environment}.yml"
      content = IO.read(file)
    end 

  end
end

