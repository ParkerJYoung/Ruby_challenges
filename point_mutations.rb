=begin
  example GAGCCTACTAACGGGAT
          CATCGTAATGACGGCCT

  input- an object of the DNA class with strand instance variable passed in as a string
  output - number of differences between the strand of calling object and strand passed into hamming_distance method

  data structures - array of each letter of the input string as elements

  algorithm - break strings into arrays with each letter being the element
            - iterate through each array with a loop and check if the elements are equal
            - if they aren't equal then increment the count by 1
            - return the count
=end

class DNA
  attr_reader :strand

  def initialize(str)
    @strand = str.split('')
  end

  def hamming_distance(other_strand)
    strand1 = strand
    strand2 = other_strand.split('')

    loop do
      if strand1.size != strand2.size
        if strand1.size > strand2.size
          strand1.pop
        else   
          strand2.pop
        end
      end
      break if strand_size_equal?(strand1, strand2)
    end
    
    number_of_mutations(strand1, strand2) 
  end

  def number_of_mutations(strand1, other_strand)
    index = 0
    mutations = 0

    loop do 
      if strand1[index] != other_strand[index]
        mutations += 1
      end
      index += 1
      break if index > strand1.size 
    end
    mutations
  end

  def strand_size_equal?(strand1, strand2)
    strand1.size == strand2.size
  end
end

require 'minitest/autorun'
require_relative 'point_mutations'

class DNATest < Minitest::Test
  def test_no_difference_between_empty_strands
    assert_equal 0, DNA.new('').hamming_distance('')
  end

  def test_no_difference_between_identical_strands
    assert_equal 0, DNA.new('GGACTGA').hamming_distance('GGACTGA')
  end

  def test_complete_hamming_distance_in_small_strand
    assert_equal 3, DNA.new('ACT').hamming_distance('GGA')
  end

  def test_hamming_distance_in_off_by_one_strand
    strand = 'GGACGGATTCTGACCTGGACTAATTTTGGGG'
    distance = 'AGGACGGATTCTGACCTGGACTAATTTTGGGG'
    assert_equal 19, DNA.new(strand).hamming_distance(distance)
  end

  def test_small_hamming_distance_in_middle_somewhere
    assert_equal 1, DNA.new('GGACG').hamming_distance('GGTCG')
  end

  def test_larger_distance
    assert_equal 2, DNA.new('ACCAGGG').hamming_distance('ACTATGG')
  end

  def test_ignores_extra_length_on_other_strand_when_longer
    assert_equal 3, DNA.new('AAACTAGGGG').hamming_distance('AGGCTAGCGGTAGGAC')
  end

  def test_ignores_extra_length_on_original_strand_when_longer
    strand = 'GACTACGGACAGGGTAGGGAAT'
    distance = 'GACATCGCACACC'
    assert_equal 5, DNA.new(strand).hamming_distance(distance)
  end

  def test_does_not_actually_shorten_original_strand
    dna = DNA.new('AGACAACAGCCAGCCGCCGGATT')
    assert_equal 1, dna.hamming_distance('AGGCAA')
    assert_equal 4, dna.hamming_distance('AGACATCTTTCAGCCGCCGGATTAGGCAA')
    assert_equal 1, dna.hamming_distance('AGG')
  end
end