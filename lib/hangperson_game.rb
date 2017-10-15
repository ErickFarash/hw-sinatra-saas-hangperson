class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass. 
  attr_accessor :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def new word
    @hangpersonGame = HangpersonGame.new(word)
  end

  def guess char
    if char =~ /[[:alpha:]]/
      char.downcase!
      if @word.include? char and !@guesses.include? char
        @guesses.concat char
        return true
      elsif !@wrong_guesses.include? char and !@word.include? char
        @wrong_guesses.concat char
        return true
      else return false end
    else
      char = :invalid
      raise ArgumentError
    end
  end

  def word_with_guesses
    result = ""
    @word.each_char do |letter|
      if @guesses.include? letter
        result.concat letter 
      else
        result.concat '-'
      end
    end
    return result
  end

  def check_win_or_lose
    counter = 0
    return :lose if @wrong_guesses.length >= 7
    @word.each_char do |letter|
      counter += 1 if @guesses.include? letter # if letter =~ /[#{@guesses}]/
    end
    if counter == @word.length then :win
    else :play end
  end
end