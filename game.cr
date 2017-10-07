require "./dictionary"
require "./guess"

# Requires macOS list of words to be present in /usr/share/dict/words
# Run:  `$ crystal hangman.cr`

class Game

  include Dictionary
  include Guess

  def play_game(guessing_algorithm = :simple)
    
    puts "\nSelecting a word from the dictionary at random...\n\n"

    word_length = word_length()
    chosen_word = get_word(word_length)
    guess_map   = chosen_word.split("").map { |x| {x, "-"} }

    print_status(guess_map)


    if [:all, :simple].includes? guessing_algorithm
      puts "Solving using simple algorithm...\n"
      iterations = simple_guesser(word_length, guess_map)

      puts "\nSolved after #{iterations} iterations with simple algorithm\n"
    end

    if [:all, :improved].includes? guessing_algorithm
      puts "Solving using improved algorithm...\n"
      iterations = improved_guesser(word_length, guess_map)
      
      puts "\nSolved after #{iterations} iterations with improved algorithm\n"
    end
  end

  
  def simple_guesser(word_length, guess_map)
    letter_vs_frequency = most_common_character_map(word_length)
    
    idx = 1
    while slots_remaining(guess_map) > 0
      guess = next_guess(letter_vs_frequency)
      puts "\nTrying with #{guess[0]}..."

      letter_vs_frequency = remove_chosen_letter(letter_vs_frequency, guess[0])

      guess_map = update_status(guess_map, guess)
      print_status(guess_map)

      idx += 1
    end

    idx
  end

  def improved_guesser(word_length, guess_map)
    idx = 1
    guessed_letters = [] of String

    while slots_remaining(guess_map) > 0
      character_frequency = most_common_character_map_with_pattern(word_length, guess_map, guessed_letters)
      guess = next_guess(character_frequency)

      puts "\nTrying with #{guess[0]}..."
      guessed_letters << guess[0]

      guess_map = update_status(guess_map, guess)
      print_status(guess_map)
      idx += 1
    end

    idx
  end
end

