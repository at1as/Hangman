# Requires macOS list of words to be present in /usr/share/dict/words
#
# Run:  `$ crystal hangman.cr`

module Dictionary

  def word_length
    (8..10).to_a.sample
  end

  def list_of_words
    File.read("/usr/share/dict/words").split("\n").group_by { |w| w.size }
  end

  def get_word(target_length)
    list_of_words[target_length].sample.downcase
  end

  def most_common_character_map(target_length)
    # Return list of tuples {letter, frequency}
    #   [ ... , {"a", 25839} , {"i", 27630} , {"e", 33296} ]
    list_of_words[target_length].flat_map { |w| w.split("") }.group_by { |c| c }.map { |k, v| {k, v.size } }
  end

end


module Guess

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
    puts "The word is #{guess_map.map { |x| x[1] }.join } (#{slots_remaining(guess_map)} of #{slots_total(guess_map)} digits remaining)"
  end

end


class Game

  include Dictionary
  include Guess

  def play_game

    puts "\nSelecting a word from the dictionary at random...\n\n"

    word_length = word_length()
    chosen_word = get_word(word_length)
    guess_map   = chosen_word.split("").map { |x| {x, "-"} }

    letter_vs_frequency = most_common_character_map(word_length)
    
    print_status(guess_map)


    while slots_remaining(guess_map) > 0
      guess = next_guess(letter_vs_frequency)

      puts "\nTrying #{guess[0]}..."

      letter_vs_frequency = remove_chosen_letter(letter_vs_frequency, guess[0])

      guess_map = update_status(guess_map, guess)
      print_status(guess_map)
    end

  end
end


Game.new.play_game
