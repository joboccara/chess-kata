require_relative '../lib/board'
require_relative '../lib/outcome'

class TestBoard < Board
  def position_piece(coordinate, piece)
    super
  end
end

def assert_failure(outcome, message)
  refute outcome.success
  assert_equal message, outcome.output
end

def assert_success(outcome)
  assert outcome.success, outcome.output
end
