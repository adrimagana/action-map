# frozen_string_literal: true

Given /the following representatives exist/ do |rep_table|
  rep_table.hashes.each do |rep|
    Representative.create!(
      name:  rep[:name],
      ocdid: rep[:divisionId],
      title: rep[:office]
    )
  end
end

Then /^I should see the representatives: (.*)$/ do |rep_list|
  rep_list.split(',').each do |rep|
    step "I should see #{rep}"
  end
end

When /^I navigate to the (.* County) in (.*)$/ do |county, state|
  state = State.find_by(name: state)
  address = "#{county} #{state}"
  visit search_representatives_path(address: address)
end
