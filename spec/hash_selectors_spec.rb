require File.expand_path('../spec_helper', __FILE__)
require 'hash_selectors'

RSpec.describe HashSelectors do

  describe "Constants"

  ### INSTANCE METHODS

  describe "#merge_into" do
    context "assuming a Hash: {a: {}, b: 2, c: 3}}" do
      let(:the_hash) { {a: {}, b: 2, c: 3} }
      context "and given :a, {a1: :a2}" do
        subject { the_hash.merge_into(:a, {a1: :a2}) }
        it { is_expected.to eq({a: {a1: :a2}, b: 2, c: 3}) }
      end
    end
    context "assuming a Hash: {a: {1 => 2}, b: 2, c: 3}}" do
      let(:the_hash) { {a: {1 => 2}, b: 2, c: 3} }
      context "and given :a, {a1: :a2}" do
        subject { the_hash.merge_into(:a, {a1: :a2}) }
        it { is_expected.to eq({a: {:a1 => :a2, 1 => 2}, b: 2, c: 3}) }
      end
    end
    context "assuming a Hash: {a: {1 => 2}, b: 2, c: 3}}" do
      let(:the_hash) { {a: {1 => 2}, b: 2, c: 3} }
      context "and given :d, {d1: :d2}" do
        subject { the_hash.merge_into(:d, {d1: :d2}) }
        it { is_expected.to eq({a: {1 => 2}, b: 2, c: 3, d: {d1: :d2}}) }
      end
    end
  end

  describe "#partition_by_keys" do
    context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}} }
      context "and given :a, :d" do
        subject { the_hash.partition_by_keys :a, :d }
        it { is_expected.to eq([{a: 1}, {b: 2, c: {c2: [:d, :e]}}]) }
      end
      context "and given :a, :b" do
        subject { the_hash.partition_by_keys :a, :b }
        it { is_expected.to eq([{a: 1, b: 2}, {c: {c2: [:d, :e]}}]) }
      end
      context "and given :b, :c" do
        subject { the_hash.partition_by_keys :b, :c }
        it { is_expected.to eq([{b: 2, c: {c2: [:d, :e]}}, {a: 1}]) }
      end
    end
  end

  describe "#partition_by_values" do
    context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}} }
      context "and given 1, 2" do
        subject { the_hash.partition_by_values 1, 2 }
        it { is_expected.to eq([{a: 1, b: 2}, {c: {c2: [:d, :e]}}]) }
      end
    end
  end

  describe "#reject_by_keys" do
    context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}} }
      context "and given :a, :d" do
        subject { the_hash.reject_by_keys :a, :d }
        it { is_expected.to eq({b: 2, c: {c2: [:d, :e]}}) }
      end
      context "and given :a, :b" do
        subject { the_hash.reject_by_keys :a, :b }
        it { is_expected.to eq({c: {c2: [:d, :e]}}) }
      end
      context "and given :b, :c" do
        subject { the_hash.reject_by_keys :b, :c }
        it { is_expected.to eq({a: 1}) }
      end
    end
  end

  describe "#reject_by_values" do
    context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}} }
      context "and given 1, 2" do
        subject { the_hash.reject_by_values 1, 2 }
        it { is_expected.to eq({c: {c2: [:d, :e]}}) }
      end
    end
  end

  selection_prefixes = %w{ select filter }
  selection_prefixes.each do |selection_prefix|
    describe "##{selection_prefix}_by_keys" do
      context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
        let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}} }
        let(:the_meth) { "#{selection_prefix}_by_keys" }
        context "and given :a, :d" do
          subject { the_hash.send(the_meth, :a, :d) }
          it { is_expected.to eq({a: 1}) }
        end
        context "and given :a, :b" do
          subject { the_hash.send(the_meth, :a, :b) }
          it { is_expected.to eq({a: 1, b: 2}) }
        end
        context "and given :b, :c" do
          subject { the_hash.send(the_meth, :b, :c) }
          it { is_expected.to eq({b: 2, c: {c2: [:d, :e]}}) }
        end
      end
    end

    describe "##{selection_prefix}_by_values" do
      let(:the_meth) { "#{selection_prefix}_by_values" }
      context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
        let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}} }
        context "and given 1, 2" do
          subject { the_hash.send(the_meth, 1, 2) }
          it { is_expected.to eq({a: 1, b: 2}) }
        end
      end
    end
  end

  describe "#values_for_keys" do
    context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}, has_nil_value: nil} }
      context "and given :a, :d" do
        subject { the_hash.values_for_keys :a, :d }
        it { is_expected.to eq([1]) }
      end
      context "and given :a, :b" do
        subject { the_hash.values_for_keys :a, :b }
        it { is_expected.to eq([1, 2]) }
      end
      context "and given :b, :c" do
        subject { the_hash.values_for_keys :b, :c }
        it { is_expected.to eq([2, {c2: [:d, :e]}]) }
      end
      context "and given :a, :has_nil_value" do
        subject { the_hash.values_for_keys :a, :has_nil_value }
        it { is_expected.to eq([1, nil]) }
      end
    end
  end

  describe "#unfiltered_values_for_keys" do
    context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}, has_nil_value: nil} }
      context "and given :a, :d, :x" do
        subject { the_hash.unfiltered_values_for_keys :a, :d, :x }
        it { is_expected.to eq([1, nil, nil]) }
      end
      context "and given :a, :b" do
        subject { the_hash.unfiltered_values_for_keys :a, :b }
        it { is_expected.to eq([1, 2]) }
      end
      context "and given :b, :c" do
        subject { the_hash.unfiltered_values_for_keys :b, :c }
        it { is_expected.to eq([2, {c2: [:d, :e]}]) }
      end
      context "and given :a, :has_nil_value" do
        subject { the_hash.unfiltered_values_for_keys :a, :has_nil_value }
        it { is_expected.to eq([1, nil]) }
      end
    end
  end

  describe "#deep_except" do
    context "assuming a Hash: {a: 1, b: 2, c: {c1: 3, c2: 4, c3: { c3a: 5, c3b: 6}}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c1: 3, c2: 4, c3: { c3a: 5, c3b: 6}}} }
      context "and given 'c'" do
        subject { the_hash.deep_except 'c' }
        it { is_expected.to eq({a: 1, b: 2})}
      end
      context "and given 'c:c1'" do
        subject { the_hash.deep_except 'c:c1' }
        it { is_expected.to eq({a: 1, b: 2, c: {c2: 4, c3: {c3a: 5, c3b: 6}}})}
      end
      context "and given 'c:c3:c3b'" do
        subject { the_hash.deep_except 'c:c3:c3b' }
        it { is_expected.to eq({a: 1, b: 2, c: {c1: 3, c2: 4, c3: {c3a: 5}}})}
      end
      context "and given 'a', 'c:c2'" do
        subject { the_hash.deep_except 'a', 'c:c2' }
        it { is_expected.to eq({b: 2, c: {c1: 3, c3: {c3a: 5, c3b: 6}}})}
      end
      context "and given 'b', 'd'" do
        subject { the_hash.deep_except 'b', 'd' }
        it { is_expected.to eq({a: 1, c: {c1: 3, c2: 4, c3: {c3a: 5, c3b: 6}}})}
      end
      context "and given 'd', 'e:e1', 'f:f2:f2c'" do
        subject { the_hash.deep_except 'd', 'e', 'f' }
        it { is_expected.to eq(the_hash) }
      end
    end
  end
end
