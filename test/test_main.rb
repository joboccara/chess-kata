require 'minitest/autorun'
require_relative '../lib/main'

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

    assert_failure Mover.move(board, 'a1', 'a3'), 'No piece at starting position a1'
    assert_failure Mover.move(board, 'a2', 'a5'), 'Invalid move for pawn'

    # Move 1 up
    assert_success Mover.move(board, 'a2', 'a3')

    # Move 2 up from initial position
    assert_success Mover.move(board, 'a2', 'a4')

    assert_success board.position_piece('c3', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'c3', 'c5'), 'Invalid move for pawn'

  end

  def test_makes_a_pawn_capture_at_diagnoal_left
    board = TestBoard.new
    assert_success board.position_piece('b3', Piece.new(:pawn, :white))
    assert_success board.position_piece('a4', Piece.new(:pawn, :black))
    assert_success Mover.move(board, 'b3', 'a4')
  end

  def test_makes_a_pawn_capture_at_diagnoal_right
    board = TestBoard.new
    assert_success board.position_piece('b3', Piece.new(:pawn, :white))
    assert_success board.position_piece('c4', Piece.new(:pawn, :black))
    assert_success Mover.move(board, 'b3', 'c4')
  end

  def test_fails_a_pawn_capturing_at_diagonal_with_no_piece
    board = TestBoard.new
    assert_success board.position_piece('b3', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'b3', 'a4'), 'Invalid move for pawn'
    assert_failure Mover.move(board, 'b3', 'c4'), 'Invalid move for pawn'
  end


  def test_moves_a_rook_vertically
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success Mover.move(board, 'a1', 'a3')
  end

  def test_moves_a_rook_horizontally
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success Mover.move(board, 'a1', 'c1')
  end

  def test_does_not_move_rook_diagonally
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_failure Mover.move(board, 'a1', 'b2'), 'Invalid move for rook'
  end

  def test_does_not_move_rook_past_a_piece
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success board.position_piece('a3', Piece.new(:pawn, :black))
    assert_failure Mover.move(board, 'a1', 'a4'), 'Cannot move past a piece'
  end

  def test_moves_to_a_position_with_an_enemy_piece
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success board.position_piece('a3', Piece.new(:pawn, :black))
    assert_success Mover.move(board, 'a1', 'a3')
  end

  def test_does_not_move_to_a_position_with_an_ally_piece
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success board.position_piece('a3', Piece.new(:rook, :white))
    assert_failure Mover.move(board, 'a1', 'a3'), 'Cannot move to a position with an ally piece'
  end

  private

  def assert_failure(outcome, message)
    refute outcome.success
    assert_equal message, outcome.output
  end

  def assert_success(outcome)
    assert outcome.success, outcome.output
  end

end
