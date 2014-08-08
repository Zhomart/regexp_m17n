# encoding: utf-8
require 'minitest/autorun'
require_relative '../lib/regexp_m17n'
require 'iconv'

class RegexpTest < MiniTest::Unit::TestCase
  def test_non_empty_string
    raw_str   = "."

    total     = Encoding.list.count
    index     = 0
    skipped   = 0

    # On jruby, only [UTF-7] has been skipped
    # On MRI, no encoding has been skipped

    Encoding.list.each do |enc|
      print "#{index+=1}/#{total} [#{enc}]"

      str = begin
        raw_str.encode(enc) rescue Iconv.conv(raw_str.encoding.name, enc.name, raw_str)
      rescue Iconv::InvalidEncoding
        puts "  skipping"
        skipped += 1
        next
      end

      puts

      assert(RegexpM17N.non_empty?(str))
    end

    puts "#{skipped} encodings has been skipped"
  end
end
