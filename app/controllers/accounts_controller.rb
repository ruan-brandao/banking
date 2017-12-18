class AccountsController < ApplicationController
  include AccountsHelper
  before_action :authenticate_user!

  def balance
    @account = current_user.account

    if @account.present?
      render json: {balance: formatted_currency(@account.balance)}
    else
      render json: {errors: ['Account does not exist.']}, status: :not_found
    end
  end
end
