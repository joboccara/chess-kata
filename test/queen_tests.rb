require 'minitest/autorun'
require_relative 'test_helpers'
require_relative '../lib/mover'
require_relative '../lib/piece'

class QueenTests < Minitest::Test
  def test_moves_queen_horizontally
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:queen, :white))
    assert_success Mover.move(board, 'd4', 'g4')
  end

  def test_moves_queen_vertically
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:queen, :white))
    assert_success Mover.move(board, 'd4', 'd7')
  end

  def test_moves_queen_diagonally
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:queen, :white))
    assert_success Mover.move(board, 'd4', 'g7')
  end

  def test_fails_to_move_queen_to_another_position
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:queen, :white))
    assert_failure Mover.move(board, 'd4', 'f5'), 'Invalid move for queen'
  end
end
