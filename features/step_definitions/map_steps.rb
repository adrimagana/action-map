# features/step_definitions/map_steps.rb
# frozen_string_literal: true

Given /the following states exist/ do |state_table|
  state_table.hashes.each do |state|
    State.create state
  end
end

Given /a state is selected/ do
  ca = State.create!(name:         'California',
                     symbol:       'CA',
                     fips_code:    '06',
                     is_territory: 0,
                     lat_min:      '-124.409591',
                     lat_max:      '-114.131211',
                     long_min:     '32.534156',
                     long_max:     '-114.131211')
  County.create(name:       'Almeda County',
                state:      ca,
                fips_code:  1,
                fips_class: 'county01')
end

Given /test state/ do
  ca = State.create!(name:         'California',
                     symbol:       'CA',
                     fips_code:    '06',
                     created_at:   Time.zone.now,
                     updated_at:   Time.zone.now,
                     is_territory: 0,
                     lat_min:      '-124.409591',
                     lat_max:      '-114.131211',
                     long_min:     '32.534156',
                     long_max:     '-114.131211')
  County.create(
    name:       'Almeda County',
    state:      ca,
    fips_code:  1,
    fips_class: 'county01'
  )
end
