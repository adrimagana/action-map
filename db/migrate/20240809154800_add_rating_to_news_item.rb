# frozen_string_literal: true

class AddRatingToNewsItem < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :rating, :string
  end
end
