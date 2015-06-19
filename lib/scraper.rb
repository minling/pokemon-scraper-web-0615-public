require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :db
      
  def initialize(db)
    @db = db
  end

  def scrape
    pokemons = open("pokemon_index.html").read

    page = Nokogiri::HTML(pokemons)

    infocard = page.search(".infocard-tall").collect {|pokemon_info| pokemon_info.text}
    
    names = page.search(".ent-name").collect {|pokemon| pokemon.text }
    
    types = page.search(".aside").collect {|type| type.text}


    names.each_with_index do |name, index|
      Pokemon.save(name, types[index], @db)
    end
    # combination_hash = Hash[names.zip(types)]
  end

  def hp_scrape(pokemon)
    hp = open("http://pokemondb.net/pokedex/#{pokemon}").read
    binding.pry
    page = Nokogiri::HTML(hp)

    hp = page.search(".HP num.first").collect {|hp| hp.text}

  end
end

  # def pokemon_scraper
  #   pokemons = open("file:///Users/Minling/dev/SQL/pokemon-scraper-web-0615/pokemon_index.html").read   
  #   # puts page.class   # => Nokogiri::HTML::Document

  #   page = Nokogiri::HTML(pokemons)

  #   # taglines = doc.search(".home-blog-post-meta").collect { |student| student.text }
  #   names = page.search()
  # end
