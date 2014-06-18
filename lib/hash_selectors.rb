# Provides additional select methods for Hashes.
# Automatically mixed-in to Hash on load.
module HashSelectors

  # @example
  #   {a: 1, b: 2, c: 3}.reject_by_keys :a, :b # returns {a: 1, b: 2}
  #
  # @param [Glob of any type] ks
  # @return [Hash] That subset of the Hash whose keys are included within the *ks* argument.
  def reject_by_keys(*ks)
    reject { |k,v| ks.include?(k) }
  end

  # @example
  #   {a: 1, b: 2, c: 3}.reject_by_values 2, 3 # returns {b: 2, c: 3}
  #
  # @param [Glob of any type] vs
  # @return [Hash] That subset of the Hash whose values are included within the *vs* argument.
  def reject_by_values(*vs)
    reject { |k,v| vs.include?(v) }
  end

  # @example
  #   {a: 1, b: 2, c: 3}.select_by_keys :a, :b # returns {a: 1, b: 2}
  #
  # @param [Glob of any type] ks
  # @return [Hash] That subset of the Hash whose keys are included within the *ks* argument.
  def select_by_keys(*ks)
    select { |k,v| ks.include?(k) }
  end

  # @example
  #   {a: 1, b: 2, c: 3}.select_by_values 2, 3 # returns {b: 2, c: 3}
  #
  # @param [Glob of any type] vs
  # @return [Hash] That subset of the Hash whose values are included within the *vs* argument.
  def select_by_values(*vs)
    select { |k,v| vs.include?(v) }
  end

  Hash.include(self)

end
