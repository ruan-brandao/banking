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

  def transfer
    @account = current_user.account
    @destination = Account.find(params[:destination_account_id])
    @amount = params[:amount]

    if @account.transfer(@amount, @destination)
      render json: {
        transfered_amount: formatted_currency(@amount),
        current_balance: formatted_currency(@account.reload.balance)
      }
    else
      render json: {
        errors: ['The current balance is not enough to make the transfer']
      }, status: :bad_request
    end
  end
end
