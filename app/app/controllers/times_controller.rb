class TimesController < ApplicationController

  # ENV["NYT_KEY"] is key for semantic search api

  # ENV["NYT_ARTICLE_KEY"] is key for article search
  # just type:
  # export NYT_KEY=cd4937cda3eb476576b4011d2991d735:18:63558649
  # in command line to have api key in environment

  # article search api

  def self.search_articles ( query )
    query_formatted = query.gsub(" ", "+")

    uri = "http://api.nytimes.com/svc/search/v1/article?format=json&query=" + query_formatted + "+opposition&fields=title%2C+date%2C+url&api-key=" + ENV["NYT_ARTICLE_KEY"]

    result = HTTParty.get( uri )
    formatted_result = result.to_hash.symbolize_keys[:results]

  end

end
