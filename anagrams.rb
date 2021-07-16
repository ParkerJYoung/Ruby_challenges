=begin

  output => array of the original words that are anagrams

  rules 
    check 1. must be the same length
    2. must contain the same letters
    3. have the exact number of the same letters
    check 4. case does not matter

  edge cases
    check - words are not an anagram of themselves
=end

class Anagram
  attr_reader :word

  def initialize(word)
    @word = word.downcase
  end

  def match(array_of_words)
    anagrams = []

     array_of_words.each do |other_word|
      if same_length?(other_word) && different_word?(other_word) && sort_letter(word) == sort_letter(other_word)
        anagrams << other_word
      end
    end
    anagrams
  end

  def sort_letter(string)
    string.downcase.split('').sort.join
  end

  def same_length?(other_word)
    word.length == other_word.length
  end

  def different_word?(other_word)
    word != other_word.downcase
  end

end


require 'minitest/autorun'

class AnagramTest < Minitest::Test
  def test_no_matches
    detector = Anagram.new('diaper')
    assert_equal [], detector.match(%w(hello world zombies pants))
  end

  def test_detect_simple_anagram
    detector = Anagram.new('ant')
    anagrams = detector.match(%w(tan stand at))
    assert_equal ['tan'], anagrams
  end

  def test_detect_multiple_anagrams
    detector = Anagram.new('master')
    anagrams = detector.match(%w(stream pigeon maters))
    assert_equal %w(maters stream), anagrams.sort
  end

  def test_does_not_confuse_different_duplicates
    detector = Anagram.new('galea')
    assert_equal [], detector.match(['eagle'])
  end

  def test_identical_word_is_not_anagram
    detector = Anagram.new('corn')
    anagrams = detector.match %w(corn dark Corn rank CORN cron park)
    assert_equal ['cron'], anagrams
  end

  def test_eliminate_anagrams_with_same_checksum
    detector = Anagram.new('mass')
    assert_equal [], detector.match(['last'])
  end

  def test_eliminate_anagram_subsets
    detector = Anagram.new('good')
    assert_equal [], detector.match(%w(dog goody))
  end

  def test_detect_anagram
    detector = Anagram.new('listen')
    anagrams = detector.match %w(enlists google inlets banana)
    assert_equal ['inlets'], anagrams
  end

  def test_multiple_anagrams
    detector = Anagram.new('allergy')
    anagrams =
      detector.match %w( gallery ballerina regally clergy largely leading)
    assert_equal %w(gallery largely regally), anagrams.sort
  end

  def test_anagrams_are_case_insensitive
    detector = Anagram.new('Orchestra')
    anagrams = detector.match %w(cashregister Carthorse radishes)
    assert_equal ['Carthorse'], anagrams
  end
end