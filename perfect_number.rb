class PerfectNumber 
  def self.classify(num)
    self.raise if num < 0
    new(num).classify
  end

  attr_reader :number

  def initialize(num)
    @number = num
  end

  def classify
    if deficient?
      'deficient'
    elsif perfect?
      'perfect'
    elsif abundant?
      'abundant'
    end
  end

  def divisors
    array = []
    1.upto(number - 1).each do |num|
      if number % num == 0
        array << num
      end
    end
    array
  end

  def deficient?
    divisors.sum < number
  end

  def perfect?
    divisors.sum == number
  end

  def abundant?
    divisors.sum > number
  end
end


require 'minitest/autorun'

class PerfectNumberTest < Minitest::Test
  def test_initialize_perfect_number
    assert_raises StandardError do
      PerfectNumber.classify(-1)
    end
  end

  def test_classify_deficient
    assert_equal 'deficient', PerfectNumber.classify(13)
  end

  def test_classify_perfect
    assert_equal 'perfect', PerfectNumber.classify(28)
  end

  def test_classify_abundant
    assert_equal 'abundant', PerfectNumber.classify(12)
  end
end