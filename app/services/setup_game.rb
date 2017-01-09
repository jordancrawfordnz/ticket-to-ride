class SetupGame
  attr_reader :game, :errors

  def initialize(player_details:)
    @player_details = player_details
    @errors = {}
  end

  def call
    Game.transaction do
      game_instance = Game.create
      if game_instance.errors.any?
        @errors["game"] = game_instance.errors.full_messages
      end

      @player_details.each do |player_key, player_params|
        player = Player.new(player_params.merge(game: game_instance))
        player.save
        if player.errors.any?
          @errors[player_key] = player.errors.full_messages
        end
      end

      raise ActiveRecord::Rollback if @errors.any?

      if @errors.none?
        @game = game_instance
      end
    end
    @errors.none?
  end
end
