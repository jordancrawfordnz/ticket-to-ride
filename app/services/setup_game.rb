class SetupGame
  attr_reader :game, :errors

  def initialize(player_details:)
    @player_details = player_details
    @errors = []
  end

  def call
    Game.transaction do
      game_instance = Game.create
      @errors += game_instance.errors.full_messages if game_instance.errors.any?

      Player.transaction(requires_new: true) do
        @player_details.each do |player_params|
          player = Player.new(player_params.merge(game: game_instance))
          player.save
          @errors += player.errors.full_messages if player.errors.any?
        end
        raise ActiveRecord::Rollback if @errors.any?
      end

      if @errors.none?
        @game = game_instance
      end
    end
    @errors.none?
  end
end
