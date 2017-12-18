require 'rails_helper'

RSpec.describe 'Account management', type: :request do
  delegate :decode, to: ActiveSupport::JSON

  it "shows the balance of logged user's account" do
    user = FactoryBot.create(:user)
    get '/accounts/balance', headers: user.create_new_auth_token

    expect(response).to have_http_status(:ok)
    expect(decode(response.body)['balance']).to eq('R$ 0,00')
  end

  it 'shows an error message when account does not exist'
end
