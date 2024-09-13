# frozen_string_literal: true

module ApplicationHelper
  def self.state_ids_by_name
    State.all.each_with_object({}) do |state, memo|
      memo[state.name] = state.id
    end.to_h
  end

  def self.state_symbols_by_name
    State.all.each_with_object({}) do |state, memo|
      memo[state.name] = state.symbol
    end
  end

  def self.nav_items
    [
      {
        title: 'Home',
        link:  Rails.application.routes.url_helpers.root_path
      },
      {
        title: 'Events',
        link:  Rails.application.routes.url_helpers.events_path
      },
      {
        title: 'Representatives',
        link:  Rails.application.routes.url_helpers.representatives_path
      }
    ]
  end

  def self.active(curr_controller_name, nav_link)
    nav_controller = Rails.application.routes.recognize_path(nav_link, method: :get)[:controller]
    return 'bg-primary-active' if curr_controller_name == nav_controller

    ''
  end

  # // iter2 -- begin
  def self.build_article_obj(articles, index)
    article = articles[index].title
    article = "#{article}     getDescription: #{articles[index].description}"
    "#{article}     getUrl: #{articles[index].url}"
  end

  def self.parse_article_obj(article)
    # puts "Article String: #{article.inspect}"
    index1 = article.index('     getDescription: ')
    index2 = article.index('     getUrl: ')
    title = article[0..index1 - 1]
    desc = article[index1 + '     getDescription: '.length..index2]
    url = article[index2 + '     getUrl: '.length..]
    [title, desc, url]
  end
  # iter2 -- end
end
