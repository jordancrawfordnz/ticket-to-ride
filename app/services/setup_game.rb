class SetupGame
  attr_reader :game

  def initialize(player_details:)
    @player_details = player_details
  end

  def call
    @game = Game.new

    @player_details.each do |player_params|
      player = Player.new(player_params)
      @game.players.push(player)
    end

    @game.save
  end
end
