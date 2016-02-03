class Player
  attr_reader :bankroll, :hand

  def self.buy_in(bankroll)
    Player.new(bankroll)
  end

  def initialize(bankroll)
    @bankroll = bankroll
  end

  def deal_in(hand)
    @hand = hand
  end

  def respond_bet
    begin

    rescue
      retry
    end
  end

  def get_bet
    begin

    rescue
      retry
    end

    bet
  end

  def get_cards_to_trade

  end

  def take_bet(amount)
    raise "not enough money" unless amount <= @bankroll
    @bankroll -= amount
    amount
  end

  def receive_winnings(amount)
    @bankroll += amount
  end

  def return_cards
    cards = @hand.cards
    @hand = nil
    cards
  end

  def fold
    @folded = true
  end

  def unfold
    @folded = false
  end

  def folded?
    @folded = true if @bankroll == 0
    @folded
  end

  def trade_cards(old_cards, new_cards)

  end

  def <=>(other_player)

  end
end
