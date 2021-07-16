=begin
  info -  I stands for 1
          V stands for 5
          X stands for 10
          L stands for 50
          C stands for 100
          D stands for 500
          M stands for 1,000
          We don't have to worry about numbers higher than 3,000.

          Modern Roman numerals are written by expressing each digit of the number separately, 
          starting with the left most digit and skipping any digit with a value of zero

  input- integer
  output- integer converted to roman numeral format

  algortithms- 
=end

class RomanNumeral
  attr_accessor :number

  ROMAN_NUMERALS = {
    "M" => 1000,
    "CM" => 900,
    "D" => 500,
    "CD" => 400,
    "C" => 100,
    "XC" => 90,
    "L" => 50,
    "XL" => 40,
    "X" => 10,
    "IX" => 9,
    "V" => 5,
    "IV" => 4,
    "I" => 1
  }

  def initialize(number)
    @number = number
  end

  def to_roman
    num = number
    result = ''

    ROMAN_NUMERALS.each do |key, value|
      multiplier, remainder = num.divmod(value)
      if multiplier > 0
        result += (key * multiplier)
      end
      num = remainder
    end
    result
  end
end



require 'minitest/autorun'
require_relative 'roman_numerals'

class RomanNumeralsTest < Minitest::Test
  def test_1
    number = RomanNumeral.new(1)
    assert_equal 'I', number.to_roman
  end

  def test_2
    number = RomanNumeral.new(2)
    assert_equal 'II', number.to_roman
  end

  def test_3
    number = RomanNumeral.new(3)
    assert_equal 'III', number.to_roman
  end

  def test_4
    number = RomanNumeral.new(4)
    assert_equal 'IV', number.to_roman
  end

  def test_5
    number = RomanNumeral.new(5)
    assert_equal 'V', number.to_roman
  end

  def test_6
    number = RomanNumeral.new(6)
    assert_equal 'VI', number.to_roman
  end

  def test_9
    number = RomanNumeral.new(9)
    assert_equal 'IX', number.to_roman
  end

  def test_27
    number = RomanNumeral.new(27)
    assert_equal 'XXVII', number.to_roman
  end

  def test_48
    number = RomanNumeral.new(48)
    assert_equal 'XLVIII', number.to_roman
  end

  def test_59
    number = RomanNumeral.new(59)
    assert_equal 'LIX', number.to_roman
  end

  def test_93
    number = RomanNumeral.new(93)
    assert_equal 'XCIII', number.to_roman
  end

  def test_141
    number = RomanNumeral.new(141)
    assert_equal 'CXLI', number.to_roman
  end

  def test_163
    number = RomanNumeral.new(163)
    assert_equal 'CLXIII', number.to_roman
  end

  def test_402
    number = RomanNumeral.new(402)
    assert_equal 'CDII', number.to_roman
  end

  def test_575
    number = RomanNumeral.new(575)
    assert_equal 'DLXXV', number.to_roman
  end

  def test_911
    number = RomanNumeral.new(911)
    assert_equal 'CMXI', number.to_roman
  end

  def test_1024
    number = RomanNumeral.new(1024)
    assert_equal 'MXXIV', number.to_roman
  end

  def test_3000
    number = RomanNumeral.new(3000)
    assert_equal 'MMM', number.to_roman
  end
end