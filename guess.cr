module Guess

  # Input Arg guess_map is of format Array(Tuple(String, String))
  #     Unsolved : [ {"a", "-"} , ... ]
  #     Solved   : [ {"a", "a"} , ... ]

  def next_guess(frequency_hash)
    frequency_hash.max_by { |x| x[1] }
  end

  def slots_remaining(guessed)
    guessed.select { |x| x[1] == "-" }.size
  end

  def slots_total(guessed)
    guessed.size
  end

  def update_status(guess_map, next_guess)
    guess_map.map { |x| (x[0] == next_guess[0] ? [x[0], x[0]] : x) }
  end

  def remove_chosen_letter(guess_map, guessed_letter)
    guess_map.reject { |x| x[0] == guessed_letter }
  end

  def print_status(guess_map)
    puts "The word is #{guess_map.map { |x| x[1] }.join } " + 
         "(#{slots_remaining(guess_map)} of #{slots_total(guess_map)} digits remaining)"
  end

end
