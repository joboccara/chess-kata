require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'minitest'
end

require 'minitest/autorun'
require_relative 'main'

class TestBoard < Board
  def position_piece(coordinate, piece)
    super
  end
end

class OurTest < Minitest::Test

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

  def test_moves_a_pawn
    board = TestBoard.new
    assert_success board.position_piece('a2', Piece.new(:pawn, :white))

    move = Mover.move(board, 'a1', 'a3')
    assert_failure move, 'No piece at starting position a1'

    move = Mover.move(board, 'a2', 'a5')
    assert_failure move, 'Invalid move for pawn'

    move = Mover.move(board, 'a2', 'a3')
    assert_success move
    # new_board = move.output
    # assert_nil board.content('a2')
    # assert_equal Piece.new(:pawn, :white), board.content('a3')

    # move = Mover.move(board, 'a2', 'b3')
    # assert_failure move, 'No piece at starting position a1'
    # new_board = move.output
  end

  private

  def assert_failure(outcome, message)
    refute outcome.success
    assert_equal message, outcome.output
  end

  def assert_success(outcome)
    assert outcome.success
  end

end
