# frozen_string_literal: true

# Spec to check representative model is working properly
# reset
require 'rails_helper'

class RepInfo
  attr_accessor :officials, :offices
end

class Official
  attr_accessor :name, :address, :party, :photo_url
end

class Office
  attr_accessor :name, :division_id, :official_indices
end

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) { instance_double(RepInfo) } # fake object to test civic_api_to_representative_params
    let(:officials) do
      [
        instance_double(Official,
                        name:      'John Doe',
                        address:   [{ 'line1' => '123 Main St', 'city' => 'Anytown', 'state' => 'CA',
'zip' => '12345' }],
                        party:     'Independent',
                        photo_url: 'url')
      ]
    end
    let(:offices) { [instance_double(Office, name: 'Senator', division_id: 'ocdid-123', official_indices: [0])] }

    before do
      allow(rep_info).to receive(:officials).and_return(officials)
      allow(rep_info).to receive(:offices).and_return(offices)
      allow(officials[0]).to receive(:address).and_return([{ 'line1' => '123 Main St', 'city' => 'Anytown',
'state' => 'CA', 'zip' => '12345' }])
      allow(officials[0]).to receive(:party).and_return('Independent')
      allow(officials[0]).to receive(:photo_url).and_return('url')
    end

    it 'creates a new representative if one does not exist' do # checking to see it doesnt exist
      expect do
        described_class.civic_api_to_representative_params(rep_info)
      end.to change(described_class, :count).by(1)
    end

    it 'does not create a duplicate representative if one already exists' do # doesn't duplicate same senator
      described_class.create!(name: 'John Doe', ocdid: 'ocdid-123', title: 'Senator')

      expect do
        described_class.civic_api_to_representative_params(rep_info)
      end.not_to change(described_class, :count)
    end

    it 'sets the correct contact_address for the representative' do
      described_class.civic_api_to_representative_params(rep_info)
      rep = described_class.find_by(name: 'John Doe', ocdid: 'ocdid-123', title: 'Senator')
      expect(rep.contact_address).to eq([{ 'line1' => '123 Main St', 'city' => 'Anytown', 'state' => 'CA',
'zip' => '12345' }])
    end
  end
end
