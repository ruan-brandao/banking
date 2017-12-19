class AccountsController < ApplicationController
  include AccountsHelper
  before_action :authenticate_user!
  before_action :find_account
  
  def balance
    render json: {balance: formatted_currency(@account.balance)}
  end

  def transfer
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

  private

  def find_account
    @account = current_user.account
    unless @account.present?
      render json: {errors: ['Account does not exist.']}, status: :not_found
    end
  end
end
