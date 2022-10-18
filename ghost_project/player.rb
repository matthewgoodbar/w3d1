class Player

    attr_reader :name
    
    def initialize(name)
        @name = name
    end

    def guess
        puts "Player #{@name}: enter a letter:"
        return gets.chomp.downcase
    end
    
end