module RandomColor
  def self.random_color
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

  def self.generate_computer_code
    [random_color,random_color,random_color,random_color]
  end

  def self.get_code 
    print "Enter Your Secret Code, seperate by space: "
    gets.chomp.split(/\W+/)
  end
end

class StartGame
  include RandomColor

  def choose_game
    print "Welcome to Mastermind! Do you want break the code (b) or set the code (s): "
    player_choice = gets.chomp
    if player_choice == "b"
      code = RandomColor.generate_computer_code
      CodeBreaker.new.game(code)
    elsif player_choice == "s"
      code = RandomColor.get_code
      CodeMaker.new.game(code)
    else choose_game
    end
  end
end

class Mastermind
  include RandomColor

  def check_perfect_matches(guess, code)
    matches = 0
    guess.each_with_index do |guess_color,guess_index|
      if guess_color == code[guess_index]
        matches += 1
      end
    end
    return matches
  end

  def check_imperfect_matches(guess,code)
    matches = 0
    guess.uniq.each do |guess_color|
      matches += [code.count(guess_color), guess.count(guess_color)].min
    end
    return matches
  end
end

class CodeBreaker < Mastermind
       
  def get_guess 
    print "Enter Your Guess, seperate by space: "
    gets.chomp.split(/\W+/)
  end

  def game(code)
    perfect_matches = 0
    imperfect_matches = 0
    round = 0

    while round <= 12 && perfect_matches <= 4 do
      break if perfect_matches == 4
      guess = get_guess
      perfect_matches = check_perfect_matches(guess,code)
      imperfect_matches = check_imperfect_matches(guess,code) - perfect_matches # don't double count perfect matches
      round += 1
      show_guess_result(perfect_matches, imperfect_matches, round)
    end
  end

  def show_guess_result(perfect_matches, imperfect_matches, round) # will need one for each
    if imperfect_matches == 0 && perfect_matches == 0
      puts "Bummer, you got no matches"
    elsif perfect_matches > 0 && perfect_matches < 4
      puts "You guessed #{perfect_matches} perfect matches and #{imperfect_matches} imperfect matches"
    elsif perfect_matches == 4
      puts "You cracked the code! Well done"
    else
      puts "You guessed #{perfect_matches} perfect matches and #{imperfect_matches} imperfect matches"
    end
  end
end

class CodeMaker < Mastermind
  include RandomColor

  def computer_guess(round,imperfect_matches,perfect_matches,guess)
    if round == 0 
      return [RandomColor.random_color,RandomColor.random_color,RandomColor.random_color,RandomColor.random_color]
    else ai(imperfect_matches,perfect_matches,guess)
    end  
 end
  
  def ai(imperfect_matches,perfect_matches,guess)
    n = imperfect_matches + perfect_matches
    i = 0
    (4-n).times do |i|
      guess[i] = RandomColor.random_color
      i += 1
    end
    return guess
    # guess.randomize(4-n) need a function to randomize 4-n of the items in the array guess
  end

  def game(code)
    perfect_matches = 0
    imperfect_matches = 0
    round = 0
    guess = ["","","",""]

    while round <= 100 && perfect_matches <= 4 do
      break if perfect_matches == 4
      guess = computer_guess(round,imperfect_matches,perfect_matches,guess)
      perfect_matches = check_perfect_matches(guess,code)
      imperfect_matches = check_imperfect_matches(guess,code) - perfect_matches # don't double count perfect matches
      round += 1
      show_guess_result(perfect_matches, imperfect_matches, round, guess)
    end
  end   
    
  def show_guess_result(perfect_matches, imperfect_matches, round, guess) # will need one for each
    if imperfect_matches == 0 && perfect_matches == 0
      puts "Round #{round}: The computer guessed #{guess} got no matches"
    elsif perfect_matches > 0 && perfect_matches < 4
      puts "Round #{round}: The computer guessed #{guess} #{perfect_matches} perfect matches and #{imperfect_matches} imperfect matches"
    elsif perfect_matches == 4
      puts "Round #{round}: The computer cracked the code!"
    else
      puts "Round #{round}: The computer guessed #{perfect_matches} perfect matches and #{imperfect_matches} imperfect matches"
    end
  end
end


StartGame.new.choose_game