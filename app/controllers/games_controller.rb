class GamesController < ApplicationController

  require "json"
  require "open-uri"

  def new
    @letters = generate_grid(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    check_if_word(@word)
    @compare = compare(@word, @letters)
    raise
  end

  private

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def pass_params
    api = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    parse = JSON.parse(api.read)
  end

  def check_if_word(word)
    @answer = ""
    if pass_params["found"] == false
      @answer = "Sorry but #{word} is not a real word."
    else
      @answer = "#{word.capitalize} is a real word."
    end
  end

    def compare(word, letters)
      word.chars.all? do |letter|
        word.count(letter) <= letters.count(letter)
    end
  end
end
