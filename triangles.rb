#sum of the lengths of any two sides must be greater than the remaining side
#side1 + side 2 > side 3 || side2 + side3 > side1 || side1 + side3 > side2

class Triangle
  attr_reader :side1, :side2, :side3

  def initialize(side1, side2, side3)
    if legal?(side1, side2, side3)
      @side1 = side1
      @side2 = side2
      @side3 = side3
    else   
      raise ArgumentError
    end
  end

  def kind
    if equilateral?
      'equilateral'
    elsif scalene?
      'scalene'
    else  
      'isosceles'
    end
  end

  def legal?(a, b, c)
    greater_than_zero?(a,b,c) && long_enough?(a,b,c)
  end

  def long_enough?(a, b, c)
    array = [a,b,c]
    longest_side = array.max
    shortest_sides = array.min(2)
    shortest_sides.sum > longest_side
  end

  def greater_than_zero?(a, b, c)
    a > 0 && b > 0 && c > 0
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def scalene?
    side1 != side2 && side1 != side3 && side2 != side3
  end
end

require 'minitest/autorun'

class TriangleTest < Minitest::Test
  def test_equilateral_equal_sides
    triangle = Triangle.new(2, 2, 2)
    assert_equal 'equilateral', triangle.kind
  end

  def test_larger_equilateral_equal_sides
    triangle = Triangle.new(10, 10, 10)
    assert_equal 'equilateral', triangle.kind
  end

  def test_isosceles_last_two_sides_equal
    triangle = Triangle.new(3, 4, 4)
    assert_equal 'isosceles', triangle.kind
  end

  def test_isosceles_first_last_sides_equal
    triangle = Triangle.new(4, 3, 4)
    assert_equal 'isosceles', triangle.kind
  end

  def test_isosceles_first_two_sides_equal
    triangle = Triangle.new(4, 4, 3)
    assert_equal 'isosceles', triangle.kind
  end

  def test_isosceles_exactly_two_sides_equal
    triangle = Triangle.new(10, 10, 2)
    assert_equal 'isosceles', triangle.kind
  end

  def test_scalene_no_equal_sides
    triangle = Triangle.new(3, 4, 5)
    assert_equal 'scalene', triangle.kind
  end

  def test_scalene_larger_no_equal_sides
    triangle = Triangle.new(10, 11, 12)
    assert_equal 'scalene', triangle.kind
  end

  def test_scalene_no_equal_sides_descending
    triangle = Triangle.new(5, 4, 2)
    assert_equal 'scalene', triangle.kind
  end

  def test_small_triangles_are_legal
    triangle = Triangle.new(0.4, 0.6, 0.3)
    assert_equal 'scalene', triangle.kind
  end

  def test_no_size_is_illegal
    assert_raises(ArgumentError) do
      triangle = Triangle.new(0, 0, 0)
    end
  end

  def test_negative_size_is_illegal
    assert_raises(ArgumentError) do
      triangle = Triangle.new(3, 4, -5)
    end
  end

  def test_size_inequality_is_illegal
    assert_raises(ArgumentError) do
      triangle = Triangle.new(1, 1, 3)
    end
  end

  def test_size_inequality_is_illegal_2
    assert_raises(ArgumentError) do
      triangle = Triangle.new(7, 3, 2)
    end
  end

  def test_size_inequality_is_illegal_3
    assert_raises(ArgumentError) do
      triangle = Triangle.new(10, 1, 3)
    end
  end

  def test_size_inequality_is_illegal_4
    assert_raises(ArgumentError) do
      triangle = Triangle.new(1, 1, 2)
    end
  end
end