require 'minitest/autorun'
require_relative '../lib/position'

class PositionTests < Minitest::Test
  def test_coordinate_parser
    a1 = Position.parse('a1')
    assert_equal 0, a1.x
    assert_equal 0, a1.y
    assert_equal 'a1', a1.to_s

    c5 = Position.parse('c5')
    assert_equal 2, c5.x
    assert_equal 4, c5.y
    assert_equal 'c5', c5.to_s
  end
end
