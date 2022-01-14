# frozen_string_literal: true

require 'set'

# https://www.reddit.com/r/wordlegame/comments/ruqhh6/i_did_some_analysis_on_the_best_words_to_get
# https://gist.github.com/b0o/fcd431739fe483c1fe3aee9381da275d
CORRECT_WORDS = File.read('correct-words.txt').split("\n").to_set
INCORRECT_WORDS = File.read('incorrect-words.txt').split("\n").to_set

class Wordle
  attr_reader :words, :possibilities

  def initialize(words:)
    @words = words
    @possibilities = ('a'..'z').each_with_object({}) do |letter, hash|
      hash[letter] = Hash.new { |h, k| h[k] = Set.new }
    end
    words.each do |word|
      first, second, third, fourth, fifth = word.chars
      possibilities[first][0].add(word)
      possibilities[second][1].add(word)
      possibilities[third][2].add(word)
      possibilities[fourth][3].add(word)
      possibilities[fifth][4].add(word)
    end
  end

  def handle_guess(guess_results)
    green_guesses = guess_results.select { _1.color == 'g' }
    yellow_guesses = guess_results.select { _1.color == 'y' }
    black_guesses = guess_results.select { _1.color == 'b' }

    green_words = green_guesses
                  .map { |guess| possibilities[guess.letter][guess.position] }
                  .reduce(:intersection) || Set.new
    return self.class.new(words: green_words).handle_guess(yellow_guesses + black_guesses) if green_words.any?

    yellow_words = yellow_guesses
                   .map { |guess| possibilities[guess.letter].except(guess.position).values.reduce(:union) }
                   .reduce(:intersection) || Set.new
    return self.class.new(words: yellow_words).handle_guess(black_guesses) if yellow_words.any?

    words_with_black_letters = black_guesses
                               .flat_map { |guess| possibilities[guess.letter][guess.position] }
                               .reduce(Set.new, :union)
    self.class.new(words: words.difference(words_with_black_letters))
  end

  def best_green_guesses
    words
      .map do |word|
        [
          word,
          word.chars.each.with_index.sum do |letter, position|
            possibilities[letter][position].size
          end
        ]
      end
      .sort_by(&:last)
      .last(5)
      .reverse
  end

  def best_yellow_guesses
    best_letters = possibilities
                   .sort_by { |_, positions| positions.values.sum(&:size) }
                   .last(5)
                   .map(&:first)
    best_letters.permutation(5).map(&:join)
                .select { words.include?(_1) }
                .then { Wordle.new(words: _1).best_green_guesses }
  end
end

GuessResult = Struct.new(:color, :letter, :position, keyword_init: true)

green_wordle = Wordle.new(words: CORRECT_WORDS)
yellow_wordle = Wordle.new(words: CORRECT_WORDS.union(INCORRECT_WORDS))

6.times do |n|
  puts "\nBest green guesses:"
  green_wordle.best_green_guesses.each do |guess, value|
    puts "#{guess} #{value}"
  end
  puts "\nBest yellow guesses:"
  yellow_wordle.best_yellow_guesses.each do |guess, value|
    puts "#{guess} #{value}"
  end
  puts <<~TXT
    \nInput the word you guessed, followed by its letter colors.
    Example: games ybbgb
    What word did you guess?
  TXT
  word_guessed, colors = $stdin.gets.split
  if colors == 'ggggg'
    puts "Wordle #{n + 1}/6"
    break
  end
  guess_results = colors.chars
                        .zip(word_guessed.chars, 0..4)
                        .map { |color, letter, position| GuessResult.new(color:, letter:, position:) }
  green_wordle = green_wordle.handle_guess(guess_results)
  yellow_wordle = yellow_wordle.handle_guess(guess_results)
end
