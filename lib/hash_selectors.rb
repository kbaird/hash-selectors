# Provides additional select methods for Hashes.
# Automatically mixed-in to Hash on load.
module HashSelectors

  # @example
  #   {a: 1, b: 2, c: 3}.partition_by_keys :a, :b # returns [{a: 1, b: 2}, {c: 3}]
  #
  # @param [Glob of any type] ks
  # @return [Hash] Partitioned results based on whether keys are included within the *ks* argument.
  def partition_by_keys(*ks)
    ### OPTIMIZE: Simple partition with the block results in nested Arrays. Investigate.
    blk = lambda { |k,v| ks.include?(k) }
    [select(&blk), reject(&blk)]
  end

  # @example
  #   {a: 1, b: 2, c: 3}.partition_by_values 2, 3 # returns [{b: 2, c: 3}, {a: 1}]
  #
  # @param [Glob of any type] vs
  # @return [Hash] Partitioned results based on whether values are included within the *vs* argument.
  def partition_by_values(*vs)
    ### OPTIMIZE: Simple partition with the block results in nested Arrays. Investigate.
    blk = lambda { |k,v| vs.include?(v) }
    [select(&blk), reject(&blk)]
  end

  # @example
  #   {a: 1, b: 2, c: 3}.reject_by_keys :a, :b # returns {c: 3}
  #
  # @param [Glob of any type] ks
  # @return [Hash] That subset of the Hash whose keys are not found within the *ks* argument.
  def reject_by_keys(*ks)
    reject { |k,v| ks.include?(k) }
  end

  # @example
  #   {a: 1, b: 2, c: 3}.reject_by_values 2, 3 # returns {a: 1}
  #
  # @param [Glob of any type] vs
  # @return [Hash] That subset of the Hash whose values are not found within the *vs* argument.
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

  # @example
  #   {a: 1, b: 2, c: 3}.values_for_keys :a, :b # returns [1, 2]
  #
  # @param [Glob of any type] ks
  # @return [Array] The values for each respective key in the *ks* argument.
  def values_for_keys(*ks)
    ks.select { |k| key?(k) }.map { |k| self[k] }
  end

  Hash.include(self)

end
