def random_color
  number = rand(5)
  case number
  when 0
    "red"      
  when 1
    "blue"
  when 2
    "green"
  when 3
    "yellow"
  when 4
    "pink"
  when 5
    "orange"
  else 
      "Error, incorrect random number generated"
  end
end

def generate_computer_code
  [random_color,random_color,random_color,random_color]
end

def get_guess
  puts "Enter Your Guess, seperate by space"
  gets.chomp.split(/\W+/)
end

def score_guess(guess, code)
  
  
  imperfect_matches = 0
  perfect_matches = 0
  
  
  guess.each_with_index do |guess_color,guess_index|
    if guess_color == code[guess_index]
      perfect_matches += 1
      code[guess_index] = "taken"
    else
      code.each do |code_color|
        if guess_color == code_color
          imperfect_matches += 1
          code_color = "taken"
        end
      end
    end
  end
  
  if imperfect_matches == 0 && perfect_matches == 0
    puts "Bummer, you got no matches"
  elsif perfect_matches > 0 && perfect_matches < 4
    puts "You guessed #{perfect_matches} perfect matches and #{imperfect_matches} imperfect matches"
  elsif perfect_matches == 4
    puts "You cracked the code! Well done"
  else
    puts "erm.. something went wrong .. you have found a loop-hole"
  end
end
  
def game
  code = generate_computer_code
  p code

  12.times do
    score_guess(get_guess, code)
  end
end

game





