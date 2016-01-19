class GenerateRandomWord
  WORDS_FILE = 'app/assets/words.txt'

  def initialize
    @words = words_list
  end

  def call
    return @words.sample
  end

  private

  def words_list
    words = File.readlines(WORDS_FILE)
    words.map(&:strip)
  end
end
