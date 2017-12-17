class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :account

  after_create :create_account

  private

  def create_account
    self.account = Account.create(user: self, balance: 0)
    true
  end
end
