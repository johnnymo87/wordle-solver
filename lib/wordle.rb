# frozen_string_literal: true

require 'set'

# https://www.reddit.com/r/wordlegame/comments/ruqhh6/i_did_some_analysis_on_the_best_words_to_get
# https://gist.github.com/b0o/fcd431739fe483c1fe3aee9381da275d
WORDS = File.read('words.txt').split("\n").to_set

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
                               .flat_map { |guess| possibilities[guess.letter].values }
                               .reduce(Set.new, :union)
    self.class.new(words: words.difference(words_with_black_letters))
  end

  def suggest_five_guesses(unique_letters:)
    (unique_letters ? words.select { |word| word.chars.uniq.size == 5 } : words)
      .map do |word|
        [
          word,
          word.chars.each.with_index.reduce(0) do |sum, (letter, position)|
            sum + possibilities[letter][position].size
          end
        ]
      end
      .sort_by(&:last)
      .last(5)
      .reverse
  end
end

GuessResult = Struct.new(:color, :letter, :position, keyword_init: true)

wordle = Wordle.new(words: WORDS)

6.times do |n|
  puts 'Suggested words, with only unique letters:'
  puts wordle.suggest_five_guesses(unique_letters: true)
  puts 'Suggested words, with sometimes non-unique letters:'
  puts wordle.suggest_five_guesses(unique_letters: false)
  puts 'Guess? Format: word guessed, followed by letter statuses, space seperated, black is b, yellow is y, green is g. Eg. games ybbgb'
  word_guessed, colors = $stdin.gets.split
  if colors == 'ggggg'
    puts "Wordle #{n + 1}/6"
    break
  end
  wordle = colors.chars.zip(word_guessed.chars, 0..4)
                 .map { |color, letter, position| GuessResult.new(color:, letter:, position:) }
                 .then { |guess_results| wordle.handle_guess(guess_results) }
end
