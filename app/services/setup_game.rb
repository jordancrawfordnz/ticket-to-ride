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
      game_instance = Game.create!

      @player_details.each do |player_key, player_params|
        full_player_params = player_params.merge(game: game_instance,
                                                 train_pieces: INITIAL_TRAIN_PIECES)

        player = Player.create(full_player_params)

        if player.errors.none?
          deal_train_car_result = DealTrainCars.new(player: player, amount_to_deal: INITIAL_DEAL_AMOUNT).call

          if !deal_train_car_result
            @errors[player_key] ||= []
            @errors[player_key].push(NOT_ENOUGH_CARDS_TO_DEAL_MESSAGE)
          end
        else
          @errors[player_key] = player.errors.full_messages
        end
      end

      raise ActiveRecord::Rollback if @errors.any?

      @game = game_instance
    end
  end
end
