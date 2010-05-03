class Profig
  class << self
    def load(configs_dir, environment=nil)
      hash = nil 
      begin
        $VERBOSE = false
        hash = YAML.load(erb("defaults", configs_dir))
        if environment
          erb_result = erb(environment, configs_dir)
          yaml_result = YAML.load(erb_result)
          hash.recursive_merge! yaml_result
        end
      ensure
        $VERBOSE = true
      end 
      #hash["environment"] = environment
      MoStash.new hash
    end 

    def erb(environment, configs_dir)
      file = "#{configs_dir}/#{environment}.yml"
      content = IO.read(file)
      erb = ERB.new content
      erb.result binding
    rescue Exception => e
      raise Exception.new "failed erbing #{file}\n#{e.inspect}\nCONTENT of erb'd file was\n#{content.nil? ? 'EMPTY' : content}"
    end 

  end
end

class Hash
  def recursive_merge!(hash)
    self.merge!( hash ) do |key, oldval, newval|
      if oldval.class == Hash
        oldval.recursive_merge! newval
      else
        newval
      end
    end
  end
end
