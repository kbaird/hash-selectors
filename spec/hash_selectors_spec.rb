require File.expand_path('../spec_helper', __FILE__)
require 'hash_selectors'

RSpec.describe HashSelectors do

  describe "Constants"

  ### INSTANCE METHODS

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

  describe "#select_by_keys" do
    context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}} }
      context "and given :a, :d" do
        subject { the_hash.select_by_keys :a, :d }
        it { is_expected.to eq({a: 1}) }
      end
      context "and given :a, :b" do
        subject { the_hash.select_by_keys :a, :b }
        it { is_expected.to eq({a: 1, b: 2}) }
      end
      context "and given :b, :c" do
        subject { the_hash.select_by_keys :b, :c }
        it { is_expected.to eq({b: 2, c: {c2: [:d, :e]}}) }
      end
    end
  end

  describe "#select_by_values" do
    context "assuming a Hash: {a: 1, b: 2, c: {c2: [:d, :e]}}" do
      let(:the_hash) { {a: 1, b: 2, c: {c2: [:d, :e]}} }
      context "and given 1, 2" do
        subject { the_hash.select_by_values 1, 2 }
        it { is_expected.to eq({a: 1, b: 2}) }
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

end
