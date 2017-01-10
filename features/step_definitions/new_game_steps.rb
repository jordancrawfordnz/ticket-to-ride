When(/^the user inputs details about (\d+) players$/) do |player_count|
  set_player_details(limit: player_count.to_i)
end

When(/^the user fills in details about (\d+) players and (\d+) without a player name$/) do |complete_player_count, without_name_count|
  complete_player_count = complete_player_count.to_i
  set_player_details(limit: complete_player_count)
  without_name_count.to_i.times do |player_without_name_index|
    set_player_colour(player_without_name_index + complete_player_count)
  end
end

Then(/^the user is on a game page$/) do
  on_game_page?
end
