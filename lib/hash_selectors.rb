# Provides additional select methods for Hashes.
# Automatically mixed-in to Hash on load.
module HashSelectors

  # @example
  #   {a: {ak: :av}, b: 2, c: 3}.merge_into(:a, {new_k: :new_v}) # returns {a: {ak: :av, new_k: :new_v}, b: 2, c: 3}
  #
  # @param [Any] Key to merge at
  # @param [Hash] Hash of new pairs to merge at the Key
  # @return [Hash] Merged results
  def merge_into(the_key, hash_to_merge)
    sub_hash = self[the_key] || {}
    merge(the_key => sub_hash.merge(hash_to_merge))
  end

  # @example
  #   {a: 1, b: 2, c: 3}.partition_by_keys :a, :b # returns [{a: 1, b: 2}, {c: 3}]
  #
  # @param [Glob of any type] ks
  # @return [Array of Hashes] Partitioned results based on whether keys are included within the *ks* argument.
  def partition_by_keys(*ks)
    ### OPTIMIZE: Simple partition with the block results in nested Arrays. Investigate.
    blk = lambda { |k,v| ks.include?(k) }
    [select(&blk), reject(&blk)]
  end

  # @example
  #   {a: 1, b: 2, c: 3}.partition_by_values 2, 3 # returns [{b: 2, c: 3}, {a: 1}]
  #
  # @param [Glob of any type] vs
  # @return [Array of Hashes] Partitioned results based on whether values are included within the *vs* argument.
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
  # @return [Array] The values for each respective key in the *ks* argument, non-matching keys ignored.
  def values_for_keys(*ks)
    ks.select { |k| key?(k) }.map { |k| self[k] }
  end

  # @example
  #   {a: 1, b: 2, c: 3}.unfiltered_values_for_keys :a, :b, :d # returns [1, 2, nil]
  #
  # @param [Glob of any type] ks
  # @return [Array] The values for each respective key in the *ks* argument, non-matching keys returning nil.
  def unfiltered_values_for_keys(*ks)
    ks.map { |k| self[k] }
  end

  Hash.include(self)

end
