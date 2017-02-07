class SetupGame
  attr_reader :game, :errors

  INITIAL_DEAL_AMOUNT = 4
  INITIAL_TRAIN_PIECES = 45
  INITIAL_SCORE = 0
  GAME_ERROR_KEY = "game"
  NOT_ENOUGH_CARDS_TO_DEAL = "Could not deal to the player, there are not enough cards."

  def initialize(player_details:)
    @player_details = player_details
    @errors = {}
  end

  def call
    Game.transaction do
      players_with_error_keys = @player_details.each.with_object({}) do |(player_key, player_params), players_with_keys|
        full_player_params = player_params.merge(train_pieces: INITIAL_TRAIN_PIECES,
                                                 score: INITIAL_SCORE)
        players_with_keys[player_key] = Player.new(full_player_params)
      end

      # TODO: Make this better determine the first player.
      game_instance = Game.new(current_player: players_with_error_keys.values.first, players: players_with_error_keys.values)

      players_with_error_keys.each do |player_key, player|
        player.valid?

        @errors[player_key] = player.errors.full_messages if player.errors.any?
      end

      if game_instance.save
        players_with_error_keys.each do |player_key, player|
          if player.save
            deal_train_car_result = DealTrainCars.new(player: player, amount_to_deal: INITIAL_DEAL_AMOUNT).call

            if !deal_train_car_result
              @errors[player_key] ||= []
              @errors[player_key].push(NOT_ENOUGH_CARDS_TO_DEAL)
            end
          else
            @errors[player_key] = player.errors.full_messages
          end
        end
      end

      @errors[GAME_ERROR_KEY] = game_instance.errors.full_messages if game_instance.errors.any?

      if @errors.none?
        @game = game_instance
      else
        raise ActiveRecord::Rollback
      end
    end

    @game
  end
end
