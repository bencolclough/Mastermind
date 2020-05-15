module RandomColor
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
end

class Mastermind
  include RandomColor  

  def generate_computer_code
    [random_color,random_color,random_color,random_color]
  end

  def get_guess
    print "Enter Your Guess, seperate by space: "
    gets.chomp.split(/\W+/)
  end
  
  def check_perfect_matches(guess, code)
    matches = 0
    guess.each_with_index do |guess_color,guess_index|
      if guess_color == code[guess_index]
        matches += 1
      end
    end
    p matches
  end

  def check_imperfect_matches(guess,code)
    matches = 0
    guess.uniq.each do |guess_color|
      matches += [code.count(guess_color), guess.count(guess_color)].min
    end
    p matches
  end


  def check_guess(guess, code, perfect_matches, imperfect_matches)  
    # count perfect matches
    guess.each_with_index do |guess_color,guess_index|
      if guess_color == code[guess_index]
        perfect_matches += 1
      end
    end
    
    # count unique imperfect matches only
    guess.uniq.each do |guess_color|
        imperfect_matches += [code.count(guess_color), guess.count(guess_color)].min
    end
    
    # don't double count perfect matches
    imperfect_matches -= perfect_matches
    p perfect_matches
    p imperfect_matches
  end

  def show_guess_result(perfect_matches, imperfect_matches)
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

  def game
    code = generate_computer_code
    perfect_matches = 0
    imperfect_matches = 0
    round = 0
    p code

    while round <= 12 && perfect_matches <= 4 do
      guess = get_guess
      perfect_matches = check_perfect_matches(guess,code)
      p perfect_matches
      p check_imperfect_matches(guess,code)
      imperfect_matches = check_imperfect_matches(guess,code) - perfect_matches
      round += 1 # count number of rounds
      show_guess_result(perfect_matches, imperfect_matches)
    end
  end
end

b = Mastermind.new
b.game