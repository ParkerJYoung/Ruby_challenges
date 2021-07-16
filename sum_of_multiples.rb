=begin   
  1 upto the given number but not including
  if the number is a multiple of one of the given multiples
  add it to the total variable
  return the total

  16 and multiples of 3 and 5
  15 would be added twice

  if number is a multiple of 
=end


class SumOfMultiples
  attr_reader :multiples
  
  def self.to(num)
    new.to(num)
  end

  def initialize(*multiples)
    if multiples.size == 0
      @multiples = [3, 5]
    else  
      @multiples = multiples
    end
  end

  def to(number)
    array = [] 
    1.upto(number - 1).each do |num|
      multiples.each do |multiple|
        if num % multiple == 0
          array << num
        end
      end
    end
    array.uniq.sum
  end
end


require 'minitest/autorun'

class SumTest < Minitest::Test
  def test_sum_to_1
    assert_equal 0, SumOfMultiples.to(1)
  end

  def test_sum_to_3
    assert_equal 3, SumOfMultiples.to(4)
  end

  def test_sum_to_10
    assert_equal 23, SumOfMultiples.to(10)
  end

  def test_sum_to_100
    assert_equal 2_318, SumOfMultiples.to(100)
  end

  def test_sum_to_1000
    assert_equal 233_168, SumOfMultiples.to(1000)
  end

  def test_configurable_7_13_17_to_20
    assert_equal 51, SumOfMultiples.new(7, 13, 17).to(20)
  end

  def test_configurable_4_6_to_15
    assert_equal 30, SumOfMultiples.new(4, 6).to(15)
  end

  def test_configurable_5_6_8_to_150
    assert_equal 4419, SumOfMultiples.new(5, 6, 8).to(150)
  end

  def test_configurable_43_47_to_10000
    assert_equal 2_203_160, SumOfMultiples.new(43, 47).to(10_000)
  end
end