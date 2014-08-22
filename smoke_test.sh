rm hash_selectors*.gem
gem build hash_selectors.gemspec
gem i hash_selectors*.gem
echo '{a: :b}.select_by_values :b' | irb -r hash_selectors
echo 'gem push hash_selectors*.gem if successful'
