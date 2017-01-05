class SetupGame
  attr_reader :game, :errors

  def initialize(player_details:)
    @player_details = player_details
    @errors = []
  end

  def call
    game_instance = Game.new

    game_instance.transaction do
      @player_details.each do |player_params|
        player = Player.new(player_params)
        game_instance.players.push(player)
      end

      game_save_result = game_instance.save
      if game_save_result
        @game = game_instance
      else
        @errors.push(game_instance.errors.full_messages)
      end

      game_save_result
    end
  end
end
