class Account < ApplicationRecord
  belongs_to :user
  has_many :movements

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, presence: true

  def transfer(amount, destination)
    return false if amount < 0 || self.balance < amount

    Account.transaction do
      self.balance -= amount
      self.save
      self.movements.create(amount: -amount)
      destination.balance += amount
      destination.save
      destination.movements.create(amount: amount)
    end
    true
  end
end
