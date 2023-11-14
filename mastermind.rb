class Game
  @@code_arr = []
  @@guess_arr = []
  @@completely_right_guess = 0
  @@rounds_played = 1

  def initialize
    generate_code
  end

  def generate_code
    4.times do
      @@code_arr.push(rand(1..6))
    end
  end

  def guess
    puts "round #{@@rounds_played}: Enter 4 digits numbers between 1-6"
    @@guess_arr = gets.chomp.to_s.split("").map(&:to_i)

    while @@guess_arr.any? {|number| !(1..6).cover?(number) } || @@guess_arr.length != 4 do
      puts 'invalid input. Try again'
      @@guess_arr = gets.chomp.to_s.split("").map(&:to_i)
    end
    p @@guess_arr
    @@rounds_played += 1
  end

  def check_answer(guess, code)
    @@completely_right_guess = 0
    half_right_guess = 0

    #adding right guess +=1 and removing to not repeat in half guess
    4.times do |number|
      if guess[number] == code[number]
        @@completely_right_guess += 1
        code[number] = 0
        guess[number] = 7
      end
    end

    #adding half guess += 1 and deleting to not repeat in next guesses
    guess.each do |number|
        if code.include?(number)
            half_right_guess += 1
            code.delete(number)
        end
    end

    puts "#{@@completely_right_guess} digits in the right place!"
    puts "#{half_right_guess} digits in code, but in the wrong place!"
    puts ""
  end

  def play_game
    while true 
      if @@rounds_played < 9
        self.guess #able the player to still guess/ calling the method
        code_copy = @@code_arr.dup# updating the state/changing of the array to new 
        self.check_answer(@@guess_arr, code_copy)#calling the method
        if @@completely_right_guess == 4
          puts "You won!"
          break
        end
      else
        puts "no more rounds. better luck next time!"
        puts "the answer was #{@@code_arr}"#updating the state
        break
      end
    end
  end
end
  


newgame = Game.new
newgame.play_game
