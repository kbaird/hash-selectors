hash-selectors
==============

A small set of select methods for Ruby Hashes

# select_by...
{a: 1, b: 2, c: 3}.select_by_keys :a, :b # returns {a: 1, b: 2}

{a: 1, b: 2, c: 3}.select_by_values 1, 3 # returns {a: 1, c: 3}

# reject_by...
{a: 1, b: 2, c: 3}.reject_by_keys :c  # returns {a: 1, b: 2}

{a: 1, b: 2, c: 3}.reject_by_values 2 # returns {a: 1, c: 3}

# partition_by...
{a: 1, b: 2, c: 3}.partition_by_keys :a, :b # returns [{a: 1, b: 2}, {c: 3}]

{a: 1, b: 2, c: 3}.partition_by_values 1, 3 # returns [{a: 1, c: 3}, {b: 2}]

# values_for_keys
{a: 1, b: 2, c: nil}.values_for_keys :a, :c # returns [1, nil]
