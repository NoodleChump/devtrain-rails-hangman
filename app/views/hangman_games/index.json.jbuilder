json.array!(@hangman_games) do |hangman_game|
  json.extract! hangman_game, :id
  json.url hangman_game_url(hangman_game, format: :json)
end
