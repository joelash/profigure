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

