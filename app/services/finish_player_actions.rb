class FinishPlayerActions
  REQUIRED_PARAMETERS_NOT_PROVIDED = "A required parameter was not provided."

  def initialize(game:)
    if !game
      throw ArgumentError.new(REQUIRED_PARAMETERS_NOT_PROVIDED)
    end

    @game = game
  end

  def call
    if !@game.finished_action
      @game.update_attribute(:finished_action, true)
    else
      false
    end
  end
end
