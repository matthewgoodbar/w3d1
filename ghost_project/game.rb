require_relative 'player.rb'

class Game
    def initialize(*player_names)
        @dictionary = Set.new
        File.foreach("dictionary.txt") {|line| @dictionary.add(line.chomp)}
        @fragment = ""
        @players = []
        player_names.each {|name| @players << Player.new(name)}
        @current_player = @players[0]
        @previous_player = nil
        @losses = Hash.new(0)
    end

    def switch_player!
        @previous_player = @current_player
        @players.rotate!
        @current_player = @players[0]
    end

    def play_round
        take_turn(@current_player)
        if @dictionary.include?(@fragment)
            @losses[@current_player] += 1
            @fragment = ""
        end
        switch_player!
    end

    def take_turn(player)
        begin
            player_input = player.guess
            raise RuntimeError.new unless valid_play?(player_input)
            @fragment += player_input
        rescue
            puts "That's not a valid guess! Try again."
            retry
        end
    end

    def valid_play?(string)
        alphabet = 'abcdefghijklmnopqrstuvwxyz'
        return false unless string.length == 1 && alphabet.include?(string)
        @dictionary.each {|word| return true if word.start_with?(@fragment + string)}
        return false
    end
end