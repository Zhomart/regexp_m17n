# encoding: utf-8
require 'minitest/autorun'
require_relative '../lib/regexp_m17n'
require 'iconv'

class RegexpTest < MiniTest::Unit::TestCase
  def test_non_empty_string
    raw_str = "."

    Encoding.list.each do |enc, index|
      str = raw_str.encode(enc) rescue Iconv.conv(raw_str.encoding.name, enc.name, raw_str)

      assert(RegexpM17N.non_empty?(str))
    end
  end
end
