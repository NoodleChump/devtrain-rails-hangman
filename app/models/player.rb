class Player < ActiveRecord::Base
  has_many :hangman_state, :dependent => :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
end
