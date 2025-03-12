require 'csv'

# This is a hangman game.
# Computer selects a random word from the list.
# The user needs to guess it.
words_dict = CSV.read('hangman/lib/hangman_file.csv') # Reading the csv file

# Is it letter
def letter?(lookAhead)
  lookAhead =~ /[A-Za-z]/
end

# Chooses a word from list
# Word needs to be 5-12 letters
def choose_word(words_list)
  new_list = []
  words_list.each { |word| new_list.push(word[0]) if word[0].length >= 5 && word[0].length <= 12 }
  new_list[rand(new_list.length)]
end
computer_word = 'tottem'.chars # choose_word(words_dict).chars)

# One character as a users guess
def user_move(computer_word, user_list)
  game_field(computer_word, user_list)
  let = gets.chomp
  let = gets.chomp while let.length != 1 || !letter?(let)
  let.downcase
end

# Game field
def game_field(computer_word, user_list)
  (0...computer_word.length).each do |i|
    if user_list[i].nil?
      print '_'
    else
      print user_list[i]
    end
  end
  print "\n"
end

# Game start
user_list = {} # User guessed letters
while user_list.length != computer_word.length
  letter = user_move(computer_word, user_list)
  computer_word.each_with_index do |let, num|
    user_list[num] = let if let == letter
  end

  puts user_list
end
