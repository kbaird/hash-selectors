module HashSelectors

  def select_by_keys(*ks)
    select { |k,v| ks.include?(k) }
  end

  def select_by_values(*vs)
    select { |k,v| vs.include?(v) }
  end

  Hash.include(self)

end
