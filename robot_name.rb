class Robot
  attr_reader :name

  @@taken_robot_names = []

  def initialize
    @name = create_name
  end

  def create_name
    name = ''
    loop do
      name = "#{random_letter}#{random_letter}#{random_num}#{random_num}#{random_num}"
      if @@taken_robot_names.include?(name) == false
        @@taken_robot_names << name
        break
      end
    end
    name
  end

  def reset
    @name = create_name
  end

  private

  def random_num
    rand(9)
  end

  def random_letter
    letters = ('A'..'Z').to_a  
    letters[rand(26)]
  end
end


require 'minitest/autorun'

class RobotTest < Minitest::Test
  DIFFERENT_ROBOT_NAME_SEED = 1234
  SAME_INITIAL_ROBOT_NAME_SEED = 1000

  NAME_REGEXP = /^[A-Z]{2}\d{3}$/

  def test_has_name
    assert_match NAME_REGEXP, Robot.new.name
  end

  def test_name_sticks
    robot = Robot.new
    robot.name
    assert_equal robot.name, robot.name
  end

  def test_different_robots_have_different_names
    Kernel.srand DIFFERENT_ROBOT_NAME_SEED
    refute_equal Robot.new.name, Robot.new.name
  end

  def test_reset_name
    Kernel.srand DIFFERENT_ROBOT_NAME_SEED
    robot = Robot.new
    name = robot.name
    robot.reset
    name2 = robot.name
    refute_equal name, name2
    assert_match NAME_REGEXP, name2
  end

  def test_different_name_when_chosen_name_is_taken
    Kernel.srand SAME_INITIAL_ROBOT_NAME_SEED
    name1 = Robot.new.name
    Kernel.srand SAME_INITIAL_ROBOT_NAME_SEED
    name2 = Robot.new.name
    refute_equal name1, name2
  end
end