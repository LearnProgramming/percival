class BoardScore

  WIN_VALUE= 10000
  DEPTH = 4
  attr_accessor :score, :win
  
  def initialize board
    @board = board
    @win = false
    @score = 0
    score_board
  end

  def terminal
    return true if @win
  end
  

  def score_board
    @board.each_with_index do |column,i|
      column.each_with_index do |color, j|
        # up
        count = counter(color) do |k|
          @board[i][j+k]
        end
        return if won? count, color 
        @score += color * (count ** 2)

        #up diag
        count = counter(color) do |k|
          i+k < @board.size ? @board[i+k][j+k] : nil
        end
        return if won? count, color
        @score += color * (count ** 2)

        #right
        count = counter(color) do |k|
          i+k < @board.size ? @board[i+k][j] : nil
        end
        return if won? count, color

        @score += color * (count ** 2)

        #down right diag
        count = counter(color) do |k|
          j-k >= 0 and i+k < @board.size ? @board[i+k][j-k] : nil
        end
        return if won? count, color
        @score += color * (count ** 2)
        
        #down
        count = counter(color) do |k|
          j-k >= 0 ? @board[i][j-k] : nil
        end
        return if won? count, color
        @score += color * (count ** 2)
        
        #down left diag
        count = counter(color) do |k|
          j-k >= 0 and i-k >= 0 ? @board[i-k][j-k] : nil
        end
        return if won? count, color
        @score += color * (count ** 2)
        
        # left
        count = counter(color) do |k|
          i-k >= 0 ? @board[i-k][j] : nil
        end
        return if won? count, color
        @score += color * (count ** 2)

        #up left diag
        count = counter(color) do |k|
          i-k >= 0 ? @board[i-k][j+k] : nil
        end
        return if won? count, color
        @score += color * (count ** 2)

      end
    end
  end

  def counter e_color
    count = 0
    (0..3).each do |k|
      color = yield k
      if color == - e_color
        count = 0
        break
      end
      count += 1 if color == e_color
    end
    count
  end

  def won? count, color
    if count == 4
      @win = color
      @score = @win * WIN_VALUE
      return true
    end
    false
  end
end





