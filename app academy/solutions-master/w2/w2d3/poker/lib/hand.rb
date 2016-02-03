require_relative './poker_hands'
require_relative 'card'

class Hand
  include PokerHands

  attr_reader :cards

  def initialize(cards)
    @cards = cards.sort
    @rank = self.rank
    raise "must have five cards" unless @cards.length == 5
  end

  def self.winner(hands)
    hands.sort { |a, b| a <=> b }.pop
  end

  def trade_cards(old_cards, new_cards)
    raise 'cannot discard unowned card' unless has_cards?(old_cards)
    raise 'must have five cards' unless old_cards.length == new_cards.length
    discard_cards(old_cards)
    take_cards(new_cards)
  end

  def to_s
    @cards.join(" ")
  end

  private
  def sort!
  end

  def take_cards(cards)
    @cards += cards
  end

  def discard_cards(old_cards)
    @cards = @cards.reject { |card| old_cards.include?(card) }
  end

  def has_cards?(old_cards)
    old_cards.all? { |card| @cards.include?(card) }
  end
end
