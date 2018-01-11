require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'belongs to user' do
    association = described_class.reflect_on_association(:user)

    expect(association.macro).to eq(:belongs_to)
  end

  it 'has many movements' do
    association = described_class.reflect_on_association(:movements)

    expect(association.macro).to eq(:has_many)
  end

  it 'validates presence of balance' do
    account = FactoryBot.build(:account)
    account_without_balance = FactoryBot.build(:account, balance: nil)

    expect(account).to be_valid
    expect(account_without_balance).not_to be_valid
  end

  it 'must have a balance greater than or equal to zero' do
    negative_balance = FactoryBot.build(:account, balance: -1)
    zero_balance =     FactoryBot.build(:account, balance: 0)
    positive_balance = FactoryBot.build(:account, balance: 1)

    expect(negative_balance).not_to be_valid
    expect(zero_balance).to be_valid
    expect(positive_balance).to be_valid
  end

  describe '#transfer' do
    it 'fails when account balance is less than the specified amount' do
      account = FactoryBot.build(:account, balance: 10)
      destination = FactoryBot.build(:account)

       expect {
        account.transfer(15, destination)
      }.not_to change {
        [account.balance, destination.balance]
      }
    end

    it 'subtracts amount from account balance and add it to destination balance' do
      account = FactoryBot.build(:account, balance: 10)
      destination = FactoryBot.build(:account, balance: 5)

      expect{
        account.transfer(7, destination)
      }.to change {
        account.balance
      }.by(-7).and change {
        destination.balance
      }.by(7)
    end

    it 'fails when amount is less than zero' do
      account = FactoryBot.build(:account)
      destination = FactoryBot.build(:account)

      expect{
        account.transfer(-1, destination)
      }.not_to change {
        [account.balance, destination.balance]
      }
    end
  end
end
