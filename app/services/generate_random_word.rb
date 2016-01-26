class GenerateRandomWord
  WORDS_FILE = 'app/assets/words.txt'

  def call
    words.sample
  end

  private

  def words
    @words ||= File.readlines(WORDS_FILE).map(&:strip)
  end
end
