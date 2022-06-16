require 'minitest/autorun'
require_relative 'test_helpers'
require_relative '../lib/mover'
require_relative '../lib/piece'

class KnightTests < Minitest::Test
  #-------------------------
  #    | L2 |    | L3 |    |
  #-------------------------
  # L1 |    |    |    | L4 |
  #-------------------------
  #    |    | Kn |    |    |
  #-------------------------
  # L8 |    |    |    | L5 |
  #-------------------------
  #    | L7 |    | L6 |    |
  #-------------------------
  def test_moves_knight_to_L1
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_success Mover.move(board, 'd4', 'b5')
  end

  def test_moves_knight_to_L2
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_success Mover.move(board, 'd4', 'c6')
  end

  def test_moves_knight_to_L3
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_success Mover.move(board, 'd4', 'e6')
  end

  def test_moves_knight_to_L4
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_success Mover.move(board, 'd4', 'f5')
  end

  def test_moves_knight_to_L5
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_success Mover.move(board, 'd4', 'f3')
  end

  def test_moves_knight_to_L6
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_success Mover.move(board, 'd4', 'e2')
  end

  def test_moves_knight_to_L7
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_success Mover.move(board, 'd4', 'c2')
  end

  def test_moves_knight_to_L8
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_success Mover.move(board, 'd4', 'b3')
  end

  def test_fails_to_move_knight_horizontally
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_failure Mover.move(board, 'd4', 'b4'), 'Invalid move for knight'
  end

  def test_fails_to_move_knight_vertically
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_failure Mover.move(board, 'd4', 'd5'), 'Invalid move for knight'
  end

  def test_fails_to_move_knight_diagonally
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:knight, :white))
    assert_failure Mover.move(board, 'd4', 'a1'), 'Invalid move for knight'
  end
end
