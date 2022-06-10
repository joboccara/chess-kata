class Outcome
  attr_reader :success, :output
  def initialize(success, output)
    @success = success
    @output = output
  end
end