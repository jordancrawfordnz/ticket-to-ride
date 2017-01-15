class SetupGame
  attr_reader :game, :errors

  INITIAL_DEAL_AMOUNT = 4
  INITIAL_TRAIN_PIECES = 45
  NOT_ENOUGH_CARDS_TO_DEAL_MESSAGE = "Could not deal to the player, there are not enough cards."

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
        player = Player.new(player_params.merge(game: game_instance, train_pieces: INITIAL_TRAIN_PIECES))
        player.save
        if player.errors.any?
          @errors[player_key] = player.errors.full_messages
        elsif !DealTrainCars.new(player: player, amount_to_deal: INITIAL_DEAL_AMOUNT).call
          player_errors = errors = @errors[player_key] ||= []
          player_errors.push(NOT_ENOUGH_CARDS_TO_DEAL_MESSAGE)
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
