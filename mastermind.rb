def guess_array
    puts "Enter Your Guess, seperate by space"
    gets.chomp.split(/\W+/)
end

class Guesses
    def def initialize(guess_array, perfect_matches, imperfect_matches)
      @guess_array = guess_array
      @perfect_matches = perfect_matches
      @imperfect_matches = imperfect_matches
    end
end




