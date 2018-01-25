class Board
  attr_accessor :board
  def initialize()
    # On remplit le board de 9 cases vides
    @board = []
    9.times{ @board.push(BoardCase.new())}
  end

  def to_s
    list = []
    @board.each{ |caseboard|  list.push(caseboard.case_value)}
    # Mise en forme du tableau de jeu
    "   1 2 3\n   - - -\nA |%s|%s|%s|\nB |%s|%s|%s|\nC |%s|%s|%s|\n   - - -\n" % list

  end

  # On positionne le symbole dans l'emplacement 'place'
  # Comme on place toutes les positions dans un même array, on va décaler de 3 si le joueur choisit B, 6 si C et 0 si pour le reste (donc A).
  def put_on_board(symbol, place)
    place.split('')
    index = 0
    add =0
    if place[0] == 'B'
      add = 3
    elsif place[0] == 'C'
      add= 6
    else
      add= 0
    end
    index = place[1].to_i-1+ add
    @board[index].case_value = symbol
  end

end
