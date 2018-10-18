require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Scrapping
  #attr_accessor permet de définir la variable db_list afin de pouvoir l'utiliser dans toute la classe Scrapping
  attr_accessor :db_list

  def initialize
    @db_list = get_the_townhalls_info(get_all_urls_of_townhalls(get_all_the_deps))
  end

#urls des 3 départements choisis
  def get_all_the_deps
    url_list = []
    doc = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/"))
    url_list << doc.css(('tr > td')[22, 4])
    url_list << doc.css(('tr > td')[23, 4])
    url_list << doc.css(('tr > td')[24, 4])
    return url_list
  end

#urls de toutes les communes dans la liste prédéfinie
  def get_all_urls_of_townhalls(urls)
    url_list = []
    urls.each do |url|
      doc = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/#{url}"))
      doc.css('//a[class="lientxt"][href]').each do |link|
        url_list << link['href']
      end
    end
    return url_list
  end

#met dans une liste de hash les infos souhaitées
  def get_the_townhalls_info(urls)
    hash_list = []
    urls.each do |url|
      hash ={}
      doc = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/#{url}"))
      hash[:name] = doc.css('h1').text
      hash[:email] = doc.css('tr > td')[4, 2].text
      hash_list << hash
    end
    return hash_list
  end
end