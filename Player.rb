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
