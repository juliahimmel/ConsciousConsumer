class TimesController < ApplicationController
# require 'httparty'
# require 'json'
def self.semantic_concept_search( query )
  uri = "http://api.nytimes.com/svc/semantic/v2/" +
        "concept/search.json?" +
        "query=#{CGI.escape(query)}&api-key=" +
        ENV["NYT_KEY"]
  HTTParty.get( uri )
end

def  self.pp_semantic_concept_search( query )
  json = semantic_concept_search( query )
  puts "Results:\n"
  json["results"].each do |result|
    puts "\n\tconcept_name:\t#{result['concept_name']}"
    puts "\tconcept_type:\t#{result['concept_type']}"
    puts "\tconcept_uri:\t#{result['concept_uri']}" if result['concept_uri']
  end
end


def self.lookup_concept_data concept_type, concept_name
  uri = "http://api.nytimes.com/svc/semantic/v2/" +
        "concept/name/#{concept_type}/" +
        "#{CGI.escape(concept_name)}.json?&" +
        "fields=all&api-key=" + ENV["NYT_KEY"]
   HTTParty.get( uri )
end

def self.pp_lookup_concept_data concept_type, concept_name
  puts "** type: #{concept_type} name: #{concept_name}"
  json = lookup_concept_data(concept_type, concept_name)
  puts "Results:\n"
  json["results"].each do |result|    puts "\n\tLinks:"
    result["links"].each do |link|
      puts "\t\trelation: #{link['relation']}"
      puts "\t\tlink: #{link['link']}"
      puts "\t\tlink_type: #{link['link_type']}"
    end
    result["article_list"]["results"].each do |article|
      puts "\tTitle: #{article['title']}"
      puts "\tDate: #{article['date']}"
      puts "\tBody: #{article['body']}\n\n"
    end
  end
end


#article search api

def self.search_articles( query )
  uri = "http://api.nytimes.com/svc/search/v2/articlesearch.json?&fq=subject.contains:(" + query + ")&fl=headline,keywords&api-key=" + ENV["NYT_ARTICLE_KEY"] #"

   HTTParty.get( uri )
end

end
