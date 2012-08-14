require 'debugger'

class ConnectFour
  INF = 10000
  DEPTH = 5
  attr_accessor :board

  def initialize width, height
    @width, @height = width, height
    @my_board = []
    @your_board = []
    @width.times { @my_board.push [] }
  end
  
  def your_move move
    @your_board = new_board @my_board, move, -1
    rendering =  "
You dropped a piece at #{move + 1}
#{board_to_string(@your_board)}"

    bs = BoardScore.new(@your_board)
    if bs.win
      return "You win" + rendering
    end
    return rendering
  end
  
  def my_move
    my_move = get_move(@your_board)
    @my_board = new_board(@your_board, my_move, 1)
    rendering = "
I dropped a piece at #{my_move + 1}
#{board_to_string(@my_board)}"

    bs = BoardScore.new(@my_board)
    if bs.win
      return "I win!!\n\n" + rendering
    end
    return rendering
  end

  def you_won
    "You Won!!! #can't happen"
  end

  def i_won
    "I Won!!!"
  end

  def get_move board
    idx = 0
    min = INF
    (0..board.size - 1).each do |i|
      nb = new_board board, i, 1
      val = negamax nb, DEPTH, -INF, INF, -1

      if val < min
        min = val
        idx = i
      end
    end
    return idx
  end

  #negamax alpha beta pruning http://en.wikipedia.org/wiki/Negamax
  #much better than my mickey mouse implementation of minimax
  def negamax board, depth, alpha, beta, color
    bs = BoardScore.new board
    if depth == 0 or bs.terminal
      return color * bs.score
    end
    (0..(board.size - 1)).each do |i|
      nb = new_board board, i, color
      val = - negamax( nb, depth - 1, - beta, - alpha, - color)
      return val if val >= beta
      alpha = val if val >= alpha
    end
    return alpha
  end

  def new_board board, move, color
    nb = Marshal.load(Marshal.dump(board))
    nb[move].push color
    nb
  end

  def board_to_string b
    l = []
    (0..@height-1).to_a.reverse.each do |i|
      e = []
      (0..@width - 1).each do |j|
        if b[j][i].nil?
          e << ' '
        elsif b[j][i] > 0
          e << 'X'
        elsif b[j][i] < 0
          e << '0'
        end
      end
      l << e.join(' ')
    end
    return '|' + l.join("|\n|") + "|\n|1 2 3 4 5 6 7|"
  end
end
