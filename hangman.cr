# Requires macOS list of words to be present in /usr/share/dict/words
# Run:
#   #=> crystal hangman.cr

WORD_LENGTH = (8..10).to_a.sample

def list_of_words
  File.read("/usr/share/dict/words").split("\n").group_by { |w| w.size }
end

def get_word(all_words, target_length)
  all_words[target_length].sample.downcase
end

def most_common_character_map(all_words, target_length)
  # [ ... , {"a", 25839} , {"i", 27630} , {"e", 33296} ]
  all_words[target_length].flat_map { |w| w.split("") }.group_by { |c| c }.map { |k, v| {k, v.size } } #.to_h
end

#
# Guesses
#

def next_guess(frequency_hash)
  frequency_hash.max_by { |x| x[1] }
end

def slots_remaining(guessed)
  guessed.select { |x| x[1] == "-" }.size
end


def update_status(guessed, next_guess)
  guessed.map { |x| (x[0] == next_guess[0] ? [x[0], x[0]] : x)  }
end

def remove_guessed_letter(guessed, guessed_letter)
  guessed.reject { |x| x[0] == guessed_letter }
end

def print_status(guessed)
  puts "The word is #{guessed.map { |x| x[1] }.join } (#{slots_remaining(guessed)} of #{WORD_LENGTH} digits remaining)"
end


# Select Word
def play_game

  puts "\nSelecting a word from the dictionary at random...\n\n"

  word    = get_word(list_of_words, WORD_LENGTH)
  guessed = word.split("").map { |x| {x, "-"} }
  print_status(guessed)

  letter_vs_frequency = most_common_character_map(list_of_words, WORD_LENGTH)


  while slots_remaining(guessed) > 0
    guess = next_guess(letter_vs_frequency)

    puts "Trying #{guess[0]}..."

    letter_vs_frequency = remove_guessed_letter(letter_vs_frequency, guess[0])

    guessed = update_status(guessed, guess)
    print_status(guessed)
  end

end

play_game
