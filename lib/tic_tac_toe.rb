class TicTacToe

attr_reader :board, :count, :winner, :player


    def initialize
        @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts " ------------ "
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts " ------------ "
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(input, player = "X")
        @board[input] = player
    end

    def position_taken?(input)
        board[input] == "X" || board[input] == "O" ? true : false 
    end

    def valid_move?(input)
        position_taken?(input) == false && input.between?(0, 8) ? true : nil
    end

    def turn_count
        @board.count{|position| position != " "}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please select 1 - 9."
        input = gets.strip
        position = input_to_index(input)
        if valid_move?(position) 
            move(position, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        winning_combo = []
        @winner = ""
        WIN_COMBINATIONS.select do |win|
            if win.all? {|x| board[x] == "X"}
            winning_combo << win
            @winner << "X"
            elsif win.all? {|x| board[x] == "O"}
            winning_combo << win
            @winner << "O"        
            end
        end
        winning_combo == [] ? false : winning_combo.flatten
    end

    def full?
    board.any?(" ") ? false : true 
    end

    def draw?
        won? == false && full? == true ? true : false 
    end

    def over?
        draw?|| won? != false ? true : false 
    end

    def winner
        won? != false ? @winner : nil
    end

    def play
        turn until over?
        if draw?
            puts "Cat's Game!"
        elsif won? 
            puts "Congratulations #{winner}!"
        end
    end

end