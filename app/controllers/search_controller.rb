# frozen_string_literal: true

require 'google/apis/civicinfo_v2'
require 'news-api'
class SearchController < ApplicationController
  def search
    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end

  def news_select
    @new_id = params[:representative_id]
    @representative = Representative.find(@new_id)
    @issue = params[:issue]
    api_key = Rails.application.credentials[:NEWS_API_KEY]
    query = "#{@representative.name} #{@issue}"
    newsapi = News.new(api_key)
    cache_key = "news_#{query}"
    response = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      newsapi = News.new(api_key)
      newsapi.get_everything(q: query, sortBy: 'popularity', pageSize: 5, language: 'en')
    end
    @articles = NewsItem.articles(response)
    render 'my_news_items/select'
  end
end
