# frozen_string_literal: true

# The issue that we need to fix for 1.1 is we need to make sure to avoid dupliate errors
# If a representative already exists and is called again, we might have duplicates!

# merge review part 2 -- reset
class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  serialize :contact_address, Array

  def self.civic_api_to_representative_params(rep_info)
    reps = []
    rep_info.officials.each_with_index do |official, index|
      ocdid_temp, title_temp = find_office_details(rep_info, index)
      rep = find_or_update_rep(official, ocdid_temp, title_temp)
      reps.push(rep)
    end
    reps
  end

  def self.find_office_details(rep_info, index)
    office = rep_info.offices.find { |o| o.official_indices.include?(index) }
    [office&.division_id, office&.name]
  end

  def self.find_or_update_rep(official, ocdid_temp, title_temp)
    rep = Representative.find_or_initialize_by(name: official.name, ocdid: ocdid_temp, title: title_temp)
    update_rep_attrributes(rep, official)
    rep.save! if rep.new_record?
    rep
  end

  def self.update_rep_attrributes(rep, official)
    rep.assign_attributes(
      contact_address: official.address&.map { |address| address.to_h.stringify_keys },
      political_party: official.party,
      photo_url:       official.photo_url
    )
  end
end
