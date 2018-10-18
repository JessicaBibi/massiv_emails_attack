require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
load 'scrapper.rb'

# Classe permettant d'enregister les données scrappées dans un fichier csv
class AddingToDatabase

  def initialize
    @csv = nil
  end

  def puts_in_csv
    scrapy = Scrapping.new
    scrapy.perform

    @csv = CSV.open("db/townhalls.csv")
    (0..scrapy.get_the_townhalls_info.length - 1).each do |x| # Boucle enregistrant les données scrappées dans le fichier csv
      @csv << scrapy.get_the_townhalls_info[x]
    end

  end
end