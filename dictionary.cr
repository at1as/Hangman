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
    list_of_words[target_length].flat_map { |w| w.split("") }.group_by { |c| c }.map { |k, v| {k, v.size} }
  end

  def most_common_character_map_with_pattern(target_length, pattern, used_letters)
    # Same as most_common_character_map function, however will remove letters that have already been used
    # and filter words that match a regex of already known values in word

    pattern_regex    = pattern.map { |x| x[1] }.join("").gsub("-", ".")
    matching_words   = list_of_words[target_length].select { |w| /#{pattern_regex}/.match(w) }
    character_counts = matching_words.flat_map { |w| w.split("") }.group_by { |c| c }.map{ |k, v| {k, v.size} }
    character_counts.reject { |c| used_letters.includes? c[0] }
  end
end
