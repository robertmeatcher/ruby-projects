require "minitest/autorun"
require "rubygems"
require 'rest-client'
require "json"

require_relative "../lib/RuneScapeItemCount/data_processing.rb"

class TestDataProcessing < Minitest::Test

  def setup
    @data_processing = DataProcessing.new
  end

  def test_validate_input
    assert_equal(false, @data_processing.validate_input?(-1))
    assert_equal(false, @data_processing.validate_input?(10))
    assert_equal(false, @data_processing.validate_input?("A"))
    assert_equal(false, @data_processing.validate_input?("Z"))
    assert_equal(false, @data_processing.validate_input?("a"))
    assert_equal(false, @data_processing.validate_input?("z"))
    assert_equal(false, @data_processing.validate_input?("/"))
    assert_equal(false, @data_processing.validate_input?(":"))
    assert_equal(true, @data_processing.validate_input?(0))
    assert_equal(true, @data_processing.validate_input?(9))
  end

  def test_parse_JSON_from_API
    stringtoparse = '{"types":[],"alpha":[{"letter":"#","items":0},{"letter":"a","items":6},{"letter":"b","items":8},{"letter":"c","items":1}]}'
    retval = ""

    retval = @data_processing.parse_JSON_from_API(stringtoparse)

    assert('[{"letter":"#","items":0},{"letter":"a","items":6},{"letter":"b","items":8},{"letter":"c","items":1}]') == retval
  end

  def test_count_items
    itemcount = 0
    stringtoparse = '{"types":[],"alpha":[{"letter":"#","items":1},{"letter":"a","items":1},{"letter":"b","items":1},{"letter":"c","items":1},{"letter":"d","items":3},{"letter":"e","items":2},{"letter":"f","items":3},{"letter":"g","items":5},{"letter":"h","items":2},{"letter":"i","items":5},{"letter":"j","items":0},{"letter":"k","items":1},{"letter":"l","items":2},{"letter":"m","items":5},{"letter":"n","items":1},{"letter":"o","items":1},{"letter":"p","items":5},{"letter":"q","items":0},{"letter":"r","items":3},{"letter":"s","items":27},{"letter":"t","items":2},{"letter":"u","items":1},{"letter":"v","items":5},{"letter":"w","items":2},{"letter":"x","items":0},{"letter":"y","items":0},{"letter":"z","items":0}]}'

    parsedstring = JSON.parse(stringtoparse)['alpha']

    itemcount = @data_processing.count_items(parsedstring)

    assert(itemcount) == 79
  end

  def test_format_output
    assert_equal("Number of items in Familiars is 79\n", @data_processing.format_output(79, 9))
  end
end