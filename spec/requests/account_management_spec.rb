require 'rails_helper'

RSpec.describe 'Account management', type: :request do
  delegate :decode, to: ActiveSupport::JSON

  describe 'GET /accounts/balance' do
    it "shows the balance of logged user's account" do
      user = FactoryBot.create(:user)

      get '/accounts/balance', headers: user.create_new_auth_token

      expect(response).to have_http_status(:ok)
      expect(decode(response.body)['balance']).to eq('R$ 0,00')
    end

    it 'shows an error message when account does not exist' do
      user = FactoryBot.create(:user)
      user.account.destroy

      get '/accounts/balance', headers: user.create_new_auth_token

      expect(response).to have_http_status(:not_found)
      expect(decode(response.body)['errors']).to eq(['Account does not exist.'])
    end
  end

  describe 'POST /accounts/transfer' do
    let(:user) { FactoryBot.create(:user) }
    let(:account) { user.account }
    let(:destination) { FactoryBot.create(:account) }

    it 'shows an error message when account does not exist' do
      user.account.destroy
      params = {destination_account_id: account.id, amount: 1}

      post '/accounts/transfer', params: params, headers: user.create_new_auth_token, as: :json

      expect(response).to have_http_status(:not_found)
      expect(decode(response.body)['errors']).to eq(['Account does not exist.'])
    end

    it 'fails when destination account does not exist' do
      params = {destination_account_id: 6543, amount: 1}

      post '/accounts/transfer', params: params, headers: user.create_new_auth_token, as: :json

      expect(response).to have_http_status(:not_found)
      expect(decode(response.body)['errors']).to eq(["Couldn't find Account with 'id'=6543"])
    end

    it 'fails when amount is not a number' do
      params = {destination_account_id: account.id, amount: 'foo'}

      post '/accounts/transfer', params: params, headers: user.create_new_auth_token, as: :json

      expect(response).to have_http_status(:bad_request)
      expect(decode(response.body)['errors']).to eq(['The informed amount is not a number'])
    end

    it 'fails when amount is greater than current balance'
    it 'debits amount from account and credits amount to destination account'
  end
end
