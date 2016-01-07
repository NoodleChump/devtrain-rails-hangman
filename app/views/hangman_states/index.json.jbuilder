json.array!(@hangman_states) do |hangman_state|
  json.extract! hangman_state, :id
  json.url hangman_state_url(hangman_state, format: :json)
end
