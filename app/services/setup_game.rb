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
      players_with_error_keys = {}
      game_instance = Game.create do |game|
        @player_details.each do |player_key, player_params|
          full_player_params = player_params.merge(train_pieces: INITIAL_TRAIN_PIECES,
                                                   score: INITIAL_SCORE,
                                                   game: game)
          player = Player.new(full_player_params)
          if player.invalid?
            @errors[player_key] = player.errors.full_messages
          end
          players_with_error_keys[player_key] = player
        end

        # TODO: Make this better determine the first player.
          # CR: Have scope like "oldest_first", "in_creation_order"
        game.current_player = players_with_error_keys.values.first
      end

      players_with_error_keys.each do |player_key, player|
        deal_train_car_result = DealTrainCars.new(player: player, amount_to_deal: INITIAL_DEAL_AMOUNT).call

        if !deal_train_car_result
          (@errors[player_key] ||= []).push(NOT_ENOUGH_CARDS_TO_DEAL)
        end
      end

      if @errors.none?
        @game = game_instance
      else
        raise ActiveRecord::Rollback
      end
    end

    @game
  end
end
