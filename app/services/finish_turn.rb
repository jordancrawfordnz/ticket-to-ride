class FinishTurn
  REQUIRED_PARAMETERS_NOT_PROVIDED = "A required parameter was not provided."

  def initialize(game:)
    if !game
      throw ArgumentError.new(REQUIRED_PARAMETERS_NOT_PROVIDED)
    end

    @game = game
  end

  def call
    @game.with_lock do
      players = @game.players
      if @game.finished_action && players.present?
        current_player_index = players.index(@game.current_player)

        new_current_player = players[current_player_index + 1]
        if new_current_player.nil?
          new_current_player = players.first
        end

        @game.current_player = new_current_player
        @game.finished_action = false
        @game.save
      else
        false
      end
    end
  end
end
