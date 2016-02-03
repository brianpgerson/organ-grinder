require_relative 'display'

class HumanPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move(board)
    from_pos, to_pos = nil, nil

    until from_pos && to_pos
      display.render

      if from_pos
        puts "#{color}'s turn. Move to where?"
        to_pos = display.get_input

        display.reset! if to_pos
      else
        puts "#{color}'s turn. Move from where?"
        from_pos = display.get_input

        display.reset! if from_pos
      end
    end

    [from_pos, to_pos]
  end
end
