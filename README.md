hash-selectors
==============

A small set of select methods for Ruby Hashes

{a: 1, b: 2, c: 3}.select_by_keys :a, :b # returns {a: 1, b: 2}

{a: 1, b: 2, c: 3}.select_by_values 1, 3 # returns {a: 1, c: 3}
