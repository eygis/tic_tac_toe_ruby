class Game

    attr_accessor :grid, :array, :board_update, :winner

    def initialize
        @array = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        @winner = nil
    end
    def grid
        "
        #{@array[0]}|#{@array[1]}|#{@array[2]}
        -+-+-
        #{@array[3]}|#{@array[4]}|#{@array[5]}
        -+-+-
        #{@array[6]}|#{@array[7]}|#{@array[8]}"
    end
    def board_update(piece, num)
        array[num] = piece
    end
end

WINCOMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
]

GAME = Game.new

class Player

    attr_accessor :name, :piece, :moves

    def initialize(player_obj)
        @name = player_obj[:name]
        @piece = player_obj[:piece]
        @moves = []
    end
    def make_move
        space = choose_space(name)
        until GAME.array[space].class == Integer
            puts 'Invalid choice. Please choose another valid space.'
            space = choose_space(name)
        end
        GAME.board_update(piece, space)
        moves.push(space)
        puts GAME.grid
        if WINCOMBINATIONS.any? {|combo| combo.all? {|c| moves.include? c}}
            !GAME.winner ? GAME.winner = name : return
        end
    end
end

def create_player(num)
    print "Please enter a name for Player #{num}: "
    @name = gets.chomp
    until @name.match?(/\A[a-zA-Z]*\z/) do
        print "Please enter a name for Player #{num} (alpha only): "
        @name = gets.chomp
    end
    print "Please choose a game piece for Player #{num}: "
    @piece = gets.chomp
    until @piece.match?(/\A[a-zA-Z]\z/) do
        print "Please enter a game piece for Player #{num} (alpha only, 1 char.): "
        @piece = gets.chomp
    end
    {name: @name, piece: @piece}
end

def choose_space(name)
    print "Please choose a space for your move (#{name}): "
    gets.chomp.to_i
end

player1 = Player.new(create_player(1))
player2 = Player.new(create_player(2))

puts GAME.grid

9.times do
    player1.make_move
    break if GAME.winner || GAME.array.none? {|i| i.is_a? Integer}
    player2.make_move
    break if GAME.winner || GAME.array.none? {|i| i.is_a? Integer}
end
if GAME.winner
    puts "The winner is #{GAME.winner}!"
else
    puts "It's a tie!"
end