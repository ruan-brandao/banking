require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has one account' do
    association = described_class.reflect_on_association(:account)

    expect(association.macro).to eq(:has_one)
  end

  it 'creates a new for a newly created user' do
    user = described_class.create(email: 'foo@example.com', password: '12345678')

    expect(user.account).to be_present
    expect(user.account.balance).to eq(0)
  end
end
