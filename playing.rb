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

def set_random_code
  code = [random_color,random_color,random_color,random_color,random_color]
end

p set_random_code