require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has one account' do
    association = described_class.reflect_on_association(:account)

    expect(association.macro).to eq(:has_one)
  end
end
