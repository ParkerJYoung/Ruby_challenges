class Verse  
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def single_verse
    case line
    when 0
      zero_line_verse
    when 1
      one_line_verse
    when 2
      two_line_verse
    else  
      default_verse
    end
  end

  def default_verse
    "#{line} bottles of beer on the wall, #{line}" +
    " bottles of beer.\nTake one down and pass it around, " +
    "#{line-1} bottles of beer on the wall.\n"
  end

  def zero_line_verse
    "No more bottles of beer on the wall, no more bottles " +
    "of beer.\nGo to the store and buy some more, 99 bottles " +
    "of beer on the wall.\n"
  end

  def one_line_verse
    "1 bottle of beer on the wall, 1 bottle of beer.\n" +
    "Take it down and pass it around, no more bottles of beer " +
    "on the wall.\n"
  end

  def two_line_verse
    "2 bottles of beer on the wall, 2 bottles of beer.\n" +
    "Take one down and pass it around, 1 bottle of beer " +
    "on the wall.\n"
  end
end

class BeerSong 
  def self.verse(line)
    Verse.new(line).single_verse
  end

  def self.verses(start, stop)
    current_verse = start
    result = []

    while current_verse >= stop
      result << "#{verse(current_verse)}"
      current_verse -= 1
    end

    result.join("\n")
  end

  def self.lyrics
    verses(99,0)
  end
end

puts BeerSong.lyrics