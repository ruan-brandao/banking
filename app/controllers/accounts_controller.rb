class AccountsController < ApplicationController
  include AccountsHelper
  before_action :authenticate_user!

  def balance
    @account = current_user.account
    render json: {balance: formatted_currency(@account.balance)}
  end
end
