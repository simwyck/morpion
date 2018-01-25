class BoardCase
  attr_accessor :case_value
  # On crée une variable pour y stocker le X et O
  def initialize(symbol =" ")
    @case_value = symbol
  end
end

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

# On retrouve le nom du joueur et le symbole qu'il aura choisi
# victorious stocke son état de vainqueur ou non
class Player
  attr_accessor :name, :victorious
  attr_accessor :symbol

  def initialize(name, symbol)
    @name = name
    @victorious = false
    @symbol = symbol
  end

end

class Game
  attr_accessor :player_1, :player_2, :board, :playable_cases
  def initialize()
    # TO DO : créé 2 joueurs, créé un board
    @board = Board.new()
    # Les emplacements disponibles/possibles pour les coups à jouer
    @playable_cases = ["A1","A2","A3","B1","B2","B3","C1","C2","C3"]
  end

  def go
    # TO DO : lance la partie
    # Nombre total de tours joués
    turn_number = 1
    # On détermine qui doit jouer
    who_plays = 0
    # Contient le gagnant, retourne false si y'a pas de gagnant
    winner = false

    # On définit les sympoles et demande aux joueurs leurs nom et symbole choisi
    symbols = ["X", "O"]
    puts "===============Tic Tac Toe============="
    puts "Joueur 1, entrez votre nom"
    name_1 = gets.chomp
    puts "Joueur 2, entrez votre nom"
    name_2 = gets.chomp

    puts "#{name_1}, choisissez votre symbole (O ou X)"
    symbol_1 = gets.chomp.capitalize
    # Si le symbole est différent de X ou O, on boucle. Le symbole est mis en majuscule.
    while not ["X", "O"].include?(symbol_1)
      puts "WTF! Choisissez un symbole entre X et O!"
      symbol_1 = gets.chomp.capitalize
    end

    # On supprime un symbole après le choix du joueur 1 et affecte automatiquement celui restant au joueur 2.
    symbols.delete(symbol_1)
    symbol_2 = symbols[0]

    @player_1 = Player.new(name_1,symbol_1)
    @player_2 = Player.new(name_2, symbol_2)

    # Tant qu'il n'y'a pas de gagnant et qu'il y'a des possibilités de jeux
    puts @board
    while not (winner || @playable_cases.length == 0)
      # On récupère en même temps le coup joué
      p @playable_cases.length
      winner = turn(who_plays)
      turn_number+=1
      who_plays = (1-who_plays)
    end

    # Mise en forme pour la fin de partie
    if winner
      puts "======================================="
      puts " Bravo #{winner.name}, vous avez gagné! "
      puts "======================================="
    else
      puts "======================================="
      puts " Pas de gagnant, match nul :("
      puts "======================================="
    end

  end

  def turn(number)
    # TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
    player = [@player_1, @player_2][number]

    puts " #{player.name} à vous de jouer! "
    # On force la majuscule pour la saisie
    player_choice = gets.chomp.upcase
    # On boucle si le joueur n'entre pas une case valide
    while not @playable_cases.include?(player_choice)
      puts " #{player.name} entrez une case valide! "
      puts @playable_cases
      player_choice = gets.chomp.upcase
    end
    @board.put_on_board(player.symbol,player_choice)
    # On supprime des cases disponibles le choix du joueur
    @playable_cases.delete(player_choice)
    puts @board
    # On retourne le coup joué
    return game_over(player)
  end

  # Détermine la fin de la partie
  def game_over(player)
    # Les différentes combinaisons gagnantes
    vic_combi = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    vic_combi.each do |victorious_case|
      # On verifie si 3 symboles du joeur sont dans les cases des combinaisons gagantes
      if @board.board[victorious_case[0]].case_value+ @board.board[victorious_case[1]].case_value+ @board.board[victorious_case[2]].case_value == player.symbol*3
        # On renvoie le joeur s'il a gagné
        return player
      end
    end
    # On retourne false si le joueur n'a pas gagné
    return false
  end
end

# On lance le jeu :)
Game.new.go
