require_relative './card'
require_relative './hand'

class Deck
  def self.all_cards
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def deal_hand
    Hand.new(take(5))
  end

  def count
    @cards.length
  end

  def take(n)
    raise "not enough cards" unless n <= count
    taken_cards = []
    n.times do
      taken_cards << @cards.shift
    end
    taken_cards
  end

  def return(cards)
    cards.each do |card|
      @cards << card
    end
  end

  def shuffle
    @cards.shuffle!
  end
end
