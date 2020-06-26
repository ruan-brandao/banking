require 'rails_helper'

RSpec.describe Movement, type: :model do
  it 'belongs to account' do
    association = described_class.reflect_on_association(:account)

    expect(association.macro).to eq(:belongs_to)
  end
end
